#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/gpio.h>
#include <linux/interrupt.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Guillem Serra Cazorla");
MODULE_DESCRIPTION("Practica 1 Fase 1 ASO");
MODULE_VERSION("1.0");

static unsigned int gpioLED_A = 20;          //PIN Raspberry Led A
static unsigned int gpioLED_B = 16;          //PIN Raspberry Led B
static unsigned int gpioButton_A_On = 21;    //PIN Raspberry Button A that turns On
static unsigned int gpioButton_A_Off = 13;   //PIN Raspberry Button A that turns Off
static unsigned int gpioButton_B_On = 19;    //PIN Raspberry Button B that turns On
static unsigned int gpioButton_B_Off = 26;   //PIN Raspberry Button B that turns Off

static unsigned int irqNumber_A_On;
static unsigned int irqNumber_B_On;
static unsigned int irqNumber_A_Off;
static unsigned int irqNumber_B_Off;

static unsigned int numberPresses_A = 0;  ///< For information, store the number of button presses
static unsigned int numberPresses_B = 0;  ///< For information, store the number of button presses
static unsigned int numberPresses_C = 0;  ///< For information, store the number of button presses
static unsigned int numberPresses_D = 0;  ///< For information, store the number of button presses
static bool     ledA = 0;           ///< Is the LED A on or off? Used to invert its state (off by default)
static bool     ledB = 0;           ///< Is the LED B on or off? Used to invert its state (off by default)

/// Function prototype for the custom IRQ handler function -- see below for the implementation
static irq_handler_t  ebbgpio_irq_handler_buttonLedA_ON(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler_buttonLedA_OFF(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler_buttonLedB_ON(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler_buttonLedB_OFF(unsigned int irq, void *dev_id, struct pt_regs *regs);



static int __init ebbgpio_init(void){
   int result = 0;
   printk(KERN_INFO "GPIO_TEST: Initializing the GPIO_TEST LKM from Guillem Serra Cazorla\n");
   // Is the GPIO a valid GPIO number (e.g., the BBB has 4x32 but not all available)
   if (!gpio_is_valid(gpioLED_A) || !gpio_is_valid(gpioLED_B)){
      printk(KERN_INFO "GPIO_TEST: invalid LEDs GPIO\n");
      return -ENODEV;
   }
   // Going to set up the LEDs. It is a GPIOs in output mode and will be on by default
   ledA = false;
   gpio_request(gpioLED_A, "sysfs");
   gpio_direction_output(gpioLED_A, ledA);
   gpio_export(gpioLED_A, false);

   ledB = false;
   gpio_request(gpioLED_B, "sysfs");
   gpio_direction_output(gpioLED_B, ledB);
   gpio_export(gpioLED_B, false);

   // Goint to set up all the Buttons.
   gpio_request(gpioButton_A_On, "sysfs");
   gpio_direction_input(gpioButton_A_On);
   gpio_set_debounce(gpioButton_A_On, 200);
   gpio_export(gpioButton_A_On, false);

   gpio_request(gpioButton_A_Off, "sysfs");
   gpio_direction_input(gpioButton_A_Off);
   gpio_set_debounce(gpioButton_A_Off, 200);
   gpio_export(gpioButton_A_Off, false);

   gpio_request(gpioButton_B_On, "sysfs");
   gpio_direction_input(gpioButton_B_On);
   gpio_set_debounce(gpioButton_B_On, 200);
   gpio_export(gpioButton_B_On, false);

   gpio_request(gpioButton_B_Off, "sysfs");
   gpio_direction_input(gpioButton_B_Off);
   gpio_set_debounce(gpioButton_B_Off, 200);
   gpio_export(gpioButton_B_Off, false);


   // Going to redirect each input to a function.
   irqNumber_A_On = gpio_to_irq(gpioButton_A_On);
   result = request_irq(irqNumber_A_On, (irq_handler_t) ebbgpio_irq_handler_buttonLedA_ON, IRQF_TRIGGER_RISING, "ebb_gpio_handler_buttonLedA_ON", NULL);

   irqNumber_B_On = gpio_to_irq(gpioButton_B_On);
   result += request_irq(irqNumber_B_On, (irq_handler_t) ebbgpio_irq_handler_buttonLedB_ON, IRQF_TRIGGER_RISING, "ebb_gpio_handler_buttonLedB_ON", NULL);

   irqNumber_A_Off = gpio_to_irq(gpioButton_A_Off);
   result += request_irq(irqNumber_A_Off, (irq_handler_t) ebbgpio_irq_handler_buttonLedA_OFF, IRQF_TRIGGER_RISING, "ebb_gpio_handler_buttonLed_A_OFF", NULL);

   irqNumber_B_Off = gpio_to_irq(gpioButton_B_Off);
   result += request_irq(irqNumber_B_Off, (irq_handler_t) ebbgpio_irq_handler_buttonLedB_OFF, IRQF_TRIGGER_RISING, "ebb_gpio_handler_buttonLedB_OFF", NULL);

   printk(KERN_INFO "GPIO_TEST: The interrupt request result is: %d\n", result);
   return result;
}


static void __exit ebbgpio_exit(void){
   printk(KERN_INFO "GPIO_TEST: The button A was pressed %d times\n", numberPresses_A);
   printk(KERN_INFO "GPIO_TEST: The button B was pressed %d times\n", numberPresses_B);
   printk(KERN_INFO "GPIO_TEST: The button C was pressed %d times\n", numberPresses_C);
   printk(KERN_INFO "GPIO_TEST: The button D was pressed %d times\n", numberPresses_D);

   gpio_set_value(gpioLED_A, 0);       // Turn the LED off, makes it clear the device was unloaded
   gpio_set_value(gpioLED_B, 0);       // Turn the LED off, makes it clear the device was unloaded
   gpio_unexport(gpioLED_A);                 // Unexport the LED A GPIO
   gpio_unexport(gpioLED_B);                 // Unexport the LED B GPIO
   free_irq(irqNumber_A_On, NULL);           // Free the IRQ number, no *dev_id required in this case
   free_irq(irqNumber_B_On, NULL);           // Free the IRQ number, no *dev_id required in this case
   free_irq(irqNumber_A_Off, NULL);          // Free the IRQ number, no *dev_id required in this case
   free_irq(irqNumber_B_Off, NULL);          // Free the IRQ number, no *dev_id required in this case

   gpio_unexport(gpioButton_A_On);               // Unexport the Button GPIO
   gpio_unexport(gpioButton_A_Off);              // Unexport the Button GPIO
   gpio_unexport(gpioButton_B_On);               // Unexport the Button GPIO
   gpio_unexport(gpioButton_B_Off);              // Unexport the Button GPIO

   gpio_free(gpioLED_A);                     // Free the LED A GPIO
   gpio_free(gpioLED_B);                     // Free the LED B GPIO
   gpio_free(gpioButton_A_On);               // Free the Button A GPIO
   gpio_free(gpioButton_A_Off);              // Free the Button B GPIO
   gpio_free(gpioButton_B_On);               // Free the Button C GPIO
   gpio_free(gpioButton_B_Off);              // Free the Button D GPIO
   printk(KERN_INFO "GPIO_TEST: Goodbye from the LKM from Guillem Serra Cazorla!\n");
}


static irq_handler_t ebbgpio_irq_handler_buttonLedB_ON(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledB = true;                          // Turn the led B ON
   gpio_set_value(gpioLED_B, ledB);          // Set the physical LED accordingly

   char * argv[] = {"/usr/lib/cgi-bin/code/C.sh", NULL};
   char * env[] = {"HOME=/", NULL};
   call_usermodehelper("/usr/lib/cgi-bin/code/C.sh", argv, env, UMH_NO_WAIT);

   printk(KERN_INFO "GPIO_ButtonC: Interrupt! LED B on True\n");
   numberPresses_C++;                         // We count the number of times the button is pressed.
   return (irq_handler_t) IRQ_HANDLED;
}

static irq_handler_t ebbgpio_irq_handler_buttonLedB_OFF(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledB = false;                          // Turn the led B OFF
   gpio_set_value(gpioLED_B, ledB);

   char * argv[] = {"/usr/lib/cgi-bin/code/D.sh", NULL};
   char * env[] = {"HOME=/", NULL};
   call_usermodehelper("/usr/lib/cgi-bin/code/D.sh", argv, env, UMH_NO_WAIT);

   printk(KERN_INFO "GPIO_ButtonD: Interrupt! LED B on False\n");
   numberPresses_D++;                         // We count the number of times the button is pressed.
   return (irq_handler_t) IRQ_HANDLED;
}

static irq_handler_t ebbgpio_irq_handler_buttonLedA_ON(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledA = true;                          // Turn the led A ON
   gpio_set_value(gpioLED_A, ledA);          // Set the physical LED accordingly

   char * argv[] = {"/usr/lib/cgi-bin/code/A.sh", NULL};
   char * env[] = {"HOME=/", NULL};
   call_usermodehelper("/usr/lib/cgi-bin/code/A.sh", argv, env, UMH_NO_WAIT);

   printk(KERN_INFO "GPIO_ButtonA: Interrupt! LED A on True\n");
   numberPresses_A++;                         // We count the number of times the button is pressed.
   return (irq_handler_t) IRQ_HANDLED;
}

static irq_handler_t ebbgpio_irq_handler_buttonLedA_OFF(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledA = false;                          // Turn the led A OFF
   gpio_set_value(gpioLED_A, ledA);          // Set the physical LED accordingly

   char * argv[] = {"/usr/lib/cgi-bin/code/B.sh", NULL};
   char * env[] = {"HOME=/", NULL};
   call_usermodehelper("/usr/lib/cgi-bin/code/B.sh", argv, env, UMH_NO_WAIT);

   printk(KERN_INFO "GPIO_ButtonB: Interrupt! LED A on False\n");
   numberPresses_B++;                         // We count the number of times the button is pressed.
   return (irq_handler_t) IRQ_HANDLED;
}


module_init(ebbgpio_init);
module_exit(ebbgpio_exit);
