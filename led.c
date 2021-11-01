#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/gpio.h>
#include <linux/interrupt.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Pol Piñol Castuera");
MODULE_DESCRIPTION("P_FASE1 ASO");
MODULE_VERSION("1.0");

static unsigned int gpioLED_RED = 20;       // LED RED
static unsigned int gpioLED_GREEN = 16;    // LED GREEN
static unsigned int gpioButton1 = 26;       // Button to open LED RED
static unsigned int gpioButton2 = 19;       // Button to open LED RED
static unsigned int gpioButton3 = 13;       // Button to open LED GREEN
static unsigned int gpioButton4 = 21;       // Button to close LED GREEN

static unsigned int irqNumber1;
static unsigned int irqNumber2;
static unsigned int irqNumber3;
static unsigned int irqNumber4;
static unsigned int numberPresses1 = 0;
static unsigned int numberPresses2 = 0;
static unsigned int numberPresses3 = 0;
static unsigned int numberPresses4 = 0;
static bool	        ledOn_RED = 0;
static bool	        ledOn_GREEN = 0;

static irq_handler_t  ebbgpio_irq_handler1(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler2(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler3(unsigned int irq, void *dev_id, struct pt_regs *regs);
static irq_handler_t  ebbgpio_irq_handler4(unsigned int irq, void *dev_id, struct pt_regs *regs);

static int __init ebbgpio_init(void){
   int result1 = 0;
   int result2 = 0;
   int result3 = 0;
   int result4 = 0;
   
   printk(KERN_INFO "P_FASE1: Initializing the P_FASE1!\n");
   
   if (!gpio_is_valid(gpioLED_RED)){
      printk(KERN_INFO "P_FASE1: invalid LED RED!\n");
      return -ENODEV;
   }
   
   if (!gpio_is_valid(gpioLED_GREEN)){
      printk(KERN_INFO "P_FASE1: invalid LED GREEN!\n");
      return -ENODEV;
   }
   
   ledOn_RED = false;
   ledOn_GREEN = false;
   
   gpio_request(gpioLED_RED, "sysfs");
   gpio_direction_output(gpioLED_RED, ledOn_RED);
   gpio_export(gpioLED_RED, false);
   
   gpio_request(gpioLED_GREEN, "sysfs");
   gpio_direction_output(gpioLED_GREEN, ledOn_GREEN);
   gpio_export(gpioLED_GREEN, false);
   
   gpio_request(gpioButton1, "sysfs");
   gpio_direction_input(gpioButton1);
   gpio_set_debounce(gpioButton1, 200);
   gpio_export(gpioButton1, false);
       
   gpio_request(gpioButton2, "sysfs");
   gpio_direction_input(gpioButton2);
   gpio_set_debounce(gpioButton2, 200);
   gpio_export(gpioButton2, false);  
                                                                            
   gpio_request(gpioButton3, "sysfs");
   gpio_direction_input(gpioButton3);
   gpio_set_debounce(gpioButton3, 200);
   gpio_export(gpioButton3, false);
       
   gpio_request(gpioButton4, "sysfs");
   gpio_direction_input(gpioButton4);
   gpio_set_debounce(gpioButton4, 200);
   gpio_export(gpioButton4, false);            

   irqNumber1 = gpio_to_irq(gpioButton1);
   irqNumber2 = gpio_to_irq(gpioButton2);
   irqNumber3 = gpio_to_irq(gpioButton3);
   irqNumber4 = gpio_to_irq(gpioButton4);

   result1 = request_irq(irqNumber1, (irq_handler_t) ebbgpio_irq_handler1, IRQF_TRIGGER_RISING, "ebb_gpio_handler", NULL);
   result2 = request_irq(irqNumber2, (irq_handler_t) ebbgpio_irq_handler2, IRQF_TRIGGER_RISING, "ebb_gpio_handler", NULL);    
   result3 = request_irq(irqNumber3, (irq_handler_t) ebbgpio_irq_handler3, IRQF_TRIGGER_RISING, "ebb_gpio_handler", NULL);
   result4 = request_irq(irqNumber4, (irq_handler_t) ebbgpio_irq_handler4, IRQF_TRIGGER_RISING, "ebb_gpio_handler", NULL);                        
   
   return result3 * result4 * result1 * result2;
}

static void __exit ebbgpio_exit(void){
   printk(KERN_INFO "P_FASE1: Button1 was pressed %d times\n", numberPresses1);
   printk(KERN_INFO "P_FASE1: Button2 was pressed %d times\n", numberPresses2);
   printk(KERN_INFO "P_FASE1: Button3 was pressed %d times\n", numberPresses3);
   printk(KERN_INFO "P_FASE1: Button4 was pressed %d times\n", numberPresses4);
   gpio_set_value(gpioLED_RED, 0);
   gpio_unexport(gpioLED_RED);
   gpio_set_value(gpioLED_GREEN, 0);
   gpio_unexport(gpioLED_GREEN);
   free_irq(irqNumber1, NULL);
   free_irq(irqNumber2, NULL);
   free_irq(irqNumber3, NULL);
   free_irq(irqNumber4, NULL);
   gpio_unexport(gpioButton1);
   gpio_unexport(gpioButton2);
   gpio_unexport(gpioButton3);
   gpio_unexport(gpioButton4);
   gpio_free(gpioLED_RED);
   gpio_free(gpioLED_GREEN);
   gpio_free(gpioButton1);
   gpio_free(gpioButton2);
   gpio_free(gpioButton3);
   gpio_free(gpioButton4);
   printk(KERN_INFO "P_FASE1: Closed!\n");
}

static irq_handler_t ebbgpio_irq_handler1(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledOn_RED = true;
   gpio_set_value(gpioLED_RED, ledOn_RED);
   printk(KERN_INFO "P_FASE1: Button 1 pressed. Led1 is ON.\n");
   numberPresses1++;
   return (irq_handler_t) IRQ_HANDLED;
}

static irq_handler_t ebbgpio_irq_handler2(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledOn_RED = false;
   gpio_set_value(gpioLED_RED, ledOn_RED);
   printk(KERN_INFO "P_FASE1: Button 2 pressed. Led1 is OFF.\n");
   numberPresses2++;
   return (irq_handler_t) IRQ_HANDLED;
}

static irq_handler_t ebbgpio_irq_handler3(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledOn_GREEN = true;
   gpio_set_value(gpioLED_GREEN, ledOn_GREEN);
   printk(KERN_INFO "P_FASE1: Button 3 pressed. Led2 is ON.\n");
   numberPresses3++;
   return (irq_handler_t) IRQ_HANDLED;
}

static irq_handler_t ebbgpio_irq_handler4(unsigned int irq, void *dev_id, struct pt_regs *regs){
   ledOn_GREEN = false;
   gpio_set_value(gpioLED_GREEN, ledOn_GREEN);
   printk(KERN_INFO "P_FASE1: Button 4 pressed. Led2 is OFF.\n");
   numberPresses4++;
   return (irq_handler_t) IRQ_HANDLED;
}


module_init(ebbgpio_init);
module_exit(ebbgpio_exit);