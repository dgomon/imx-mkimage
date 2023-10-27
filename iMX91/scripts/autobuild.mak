include ../scripts/autobuild_common.mak

ifeq ($(V),1)
AT :=
else
AT := @
endif

# Aliases
nightly : nightly_evk
nightly_mek: nightly_evk
nightly_evk: nightly_mx91evk

# MX91 EVK
nightly_mx91evk: BOARD = imx91evk
nightly_mx91evk: DTB = imx91-11x11-evk
nightly_mx91evk: CPU = imx91
nightly_mx91evk: DDR = lpddr4
nightly_mx91evk: DDR_FW_VER = v202201
nightly_mx91evk: core_files

core_files:
	$(AT)rm -rf boot
	$(AT)echo "Pulling nightly for EVK board from $(SERVER)/$(DIR)"
	$(AT)echo $(BUILD)-$(N)-iMX91-evk > nightly.txt
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/imx-boot/imx-boot-tools/$(BOARD)/$(AHAB_IMG) -O $(AHAB_IMG)
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/imx-boot/imx-boot-tools/$(BOARD)/bl31-$(CPU).bin -O bl31.bin
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/imx-boot/imx-boot-tools/$(BOARD)/u-boot-$(BOARD).bin-sd -O u-boot.bin
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/imx-boot/imx-boot-tools/$(BOARD)/u-boot-spl.bin-$(BOARD)-sd -O u-boot-spl.bin
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/imx-boot/imx-boot-tools/$(BOARD)/$(DDR)_dmem_1d_$(DDR_FW_VER).bin -O $(DDR)_dmem_1d_$(DDR_FW_VER).bin
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/imx-boot/imx-boot-tools/$(BOARD)/$(DDR)_dmem_2d_$(DDR_FW_VER).bin -O $(DDR)_dmem_2d_$(DDR_FW_VER).bin
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/imx-boot/imx-boot-tools/$(BOARD)/$(DDR)_imem_1d_$(DDR_FW_VER).bin -O $(DDR)_imem_1d_$(DDR_FW_VER).bin
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/imx-boot/imx-boot-tools/$(BOARD)/$(DDR)_imem_2d_$(DDR_FW_VER).bin -O $(DDR)_imem_2d_$(DDR_FW_VER).bin
	$(AT)$(RWGET) $(SERVER)/$(DIR)/imx_dtbs -P boot -A "$(DTB)*.dtb"
	$(AT)$(WGET) -q $(SERVER)/$(DIR)/Image-$(BOARD).bin -O Image
	$(AT)mv -f Image boot
