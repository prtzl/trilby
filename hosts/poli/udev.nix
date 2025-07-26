{
  services = {
    udev = {
      extraRules = ''
        # Give CPU temp a stable device path
        # 1: Find the cpu temperature hwmon device: cat /sys/class/hwmon/hwmon{1..9}/name
        # 2: Find one with the name that would be of the cpu monitor device. Intel laptop has dedicated "coretemp", amd has a device
        # 3: Find the temperature input of the cpu core dye in the hwmon device
        # 4.a: Find unique way to find the device either by vendor/product ID (like a chip/driver) or if it's dedicated (intel coretemp) by "name"
        # 4.b: Run: udevadm info --attribute-walk --path=/sys/class/hwmon/hwmon<number> to get unique info mentioned above
        # 5: Copy pase bottom code and either use vendor/product id, name, or whatever else. For various temperatures be sure to rename the link under which it will be available!
        # Ryzen 9 9950x on Asrock x870 Pro rs
        ACTION=="add", SUBSYSTEM=="hwmon", ATTRS{vendor}=="0x1022", ATTRS{device}=="0x14e3", RUN+="/bin/sh -c 'ln -s /sys$devpath/temp1_input /dev/cpu_temp'"

        # External temperature sensor AUXTIN5 on nct6779 platform (mobo sensors)
        ACTION=="add", SUBSYSTEM=="hwmon", KERNEL=="hwmon*", ATTRS{name}=="nct6779", RUN+="/bin/sh -c 'ln -s /sys$devpath/temp9_input /dev/water_temp'"

        # External temperature sensor AUXTIN5 on nct6779 platform (mobo sensors)
        ACTION=="add", SUBSYSTEM=="hwmon", KERNEL=="hwmon*", ATTRS{name}=="nct6779", RUN+="/bin/sh -c 'ln -s /sys$devpath/temp1_input /dev/motherboard_temp'"

        # Create GPU core temp aliases with use of vid and pid of the card/interface
        ACTION=="add", SUBSYSTEM=="hwmon", ATTRS{vendor}=="0x8086", ATTRS{device}=="0xe2f0", RUN+="/bin/sh -c 'ln -s /sys$devpath/temp2_input /dev/gpu_temp'"
      '';
    };
  };
}
