/*
 * Copyright (c) 2012-2013, Eric B. Decker
 * Copyright (c) 2000-2003 The Regents of the University of California.  
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * HPL for the TI MSP430 family of microprocessors. This provides an
 * abstraction for general-purpose I/O.
 *
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 * @author Peter Bigot <pab@peoplepowerco.com>
 * @author Eric B. Decker <cire831@gmail.com>
 */

#include "TinyError.h"

interface HplMsp430GeneralIO {
  /**
   * Set pin to high.
   */
  async command void set();

  /**
   * Set pin to low.
   */
  async command void clr();

  /**
   * Toggle pin status.
   */
  async command void toggle();

  /**
   * Get the port status that contains the pin.
   *
   * @return Status of the port that contains the given pin. The x'th
   * pin on the port will be represented in the x'th bit.
   */
  async command uint8_t getRaw();

  /**
   * Read pin value.
   *
   * @return TRUE if pin is high, FALSE otherwise.
   */
  async command bool get();

  /**
   * Set pin direction to input.
   */
  async command void makeInput();
  async command bool isInput();
  
  /**
   * Set pin direction to output.
   */
  async command void makeOutput();
  async command bool isOutput();
  
  /**
   * Set pin for module specific functionality.
   */
  async command void selectModuleFunc();
  async command bool isModuleFunc();
  
  /**
   * Set pin for I/O functionality.
   */
  async command void selectIOFunc();
  async command bool isIOFunc();

  /**
   * Set pin pullup / pull down resistor mode.
   * @param mode One of the MSP430_PORT_RESISTOR_* values
   * @return EINVAL if invalid mode or pin does not support resistor configuration;
   * FAIL if pin is not an input;
   * SUCCESS if pin supports resistor configuration, is an input, and mode is valid
   */
  async command error_t setResistor(uint8_t mode);

  /**
   * set resistor mode directly.
   *
   * You have to know what you are doing when you use these.  These routines
   * assume that the port is set for input (PxDIR).  The routines explicitly
   * change the value of the bits setting in PxOUT.
   *
   * The advantage of using these routines is efficiency because there is no
   * mode checking.  In addition, no error check is done to make sure that the
   * port is in input mode.  The thing is, first, this is something that you
   * get right once and then it doesn't change so why check and, second no
   * one actually checks the error return because there really isn't any
   * point to doing the check because this isn't something you actually need
   * to check the return code for.  So why have one.
   */
  async command void resistorOff();
  async command void resistorPullDown();
  async command void resistorPullUp();


  /**
   * Get the pin pullup / pulldown resistor mode.
   *
   * @return one of the MSP430_PORT_RESISTOR_* values
   */
  async command uint8_t getResistor();

  /** 
   * Set port drive strength.
   * @param mode: MSP430_PORT_DRIVE_STRENGTH_*
   * @return EINVAL if invalid mode or pin doesn't support drive
   *     strength config.
   * FAIL if pin is not an output
   * SUCCESS if pin supports it, is an output, and mode is valid
   */
  async command error_t setDriveStrength(uint8_t mode);

  /**
   * Get drive strength.
   * @return MSP430_PORT_DRIVE_STRENGTH_*
   */
  async command uint8_t getDriveStrength(); 
}
