
  # daq2

if {$sys_zynq == 1} {

  set spi_csn_2_o     [create_bd_port -dir O spi_csn_2_o]
  set spi_csn_1_o     [create_bd_port -dir O spi_csn_1_o]
  set spi_csn_0_o     [create_bd_port -dir O spi_csn_0_o]
  set spi_csn_i       [create_bd_port -dir I spi_csn_i]

} else {

  set spi_csn_o       [create_bd_port -dir O -from 2 -to 0 spi_csn_o]
  set spi_csn_i       [create_bd_port -dir I -from 2 -to 0 spi_csn_i]
}

  set spi_clk_i       [create_bd_port -dir I spi_clk_i]
  set spi_clk_o       [create_bd_port -dir O spi_clk_o]
  set spi_sdo_i       [create_bd_port -dir I spi_sdo_i]
  set spi_sdo_o       [create_bd_port -dir O spi_sdo_o]
  set spi_sdi_i       [create_bd_port -dir I spi_sdi_i]

  set rx_ref_clk      [create_bd_port -dir I rx_ref_clk]
  set rx_sync         [create_bd_port -dir O rx_sync]
  set rx_sysref       [create_bd_port -dir I rx_sysref]
  set rx_data_p       [create_bd_port -dir I -from 3 -to 0 rx_data_p]
  set rx_data_n       [create_bd_port -dir I -from 3 -to 0 rx_data_n]

  set tx_ref_clk      [create_bd_port -dir I tx_ref_clk]
  set tx_sync         [create_bd_port -dir I tx_sync]
  set tx_sysref       [create_bd_port -dir I tx_sysref]
  set tx_data_p       [create_bd_port -dir O -from 3 -to 0 tx_data_p]
  set tx_data_n       [create_bd_port -dir O -from 3 -to 0 tx_data_n]

if {$sys_zynq == 0} {

  set gpio_ctl_i      [create_bd_port -dir I -from 5 -to 0 gpio_ctl_i]
  set gpio_ctl_o      [create_bd_port -dir O -from 5 -to 0 gpio_ctl_o]
  set gpio_ctl_t      [create_bd_port -dir O -from 5 -to 0 gpio_ctl_t]
  set gpio_status_i   [create_bd_port -dir I -from 4 -to 0 gpio_status_i]
  set gpio_status_o   [create_bd_port -dir O -from 4 -to 0 gpio_status_o]
  set gpio_status_t   [create_bd_port -dir O -from 4 -to 0 gpio_status_t]
}

  set dac_clk         [create_bd_port -dir O dac_clk]
  set dac_valid_0     [create_bd_port -dir O dac_valid_0]
  set dac_enable_0    [create_bd_port -dir O dac_enable_0]
  set dac_ddata_0     [create_bd_port -dir I -from 63 -to 0 dac_ddata_0]
  set dac_valid_1     [create_bd_port -dir O dac_valid_1]
  set dac_enable_1    [create_bd_port -dir O dac_enable_1]
  set dac_ddata_1     [create_bd_port -dir I -from 63 -to 0 dac_ddata_1]
  set dac_valid_2     [create_bd_port -dir O dac_valid_2]
  set dac_enable_2    [create_bd_port -dir O dac_enable_2]
  set dac_ddata_2     [create_bd_port -dir I -from 63 -to 0 dac_ddata_2]
  set dac_valid_3     [create_bd_port -dir O dac_valid_3]
  set dac_enable_3    [create_bd_port -dir O dac_enable_3]
  set dac_ddata_3     [create_bd_port -dir I -from 63 -to 0 dac_ddata_3]
  set dac_drd         [create_bd_port -dir I dac_drd]
  set dac_ddata       [create_bd_port -dir O -from 127 -to 0 dac_ddata]

  set adc_clk         [create_bd_port -dir O adc_clk]
  set adc_enable_0    [create_bd_port -dir O adc_enable_0]
  set adc_valid_0     [create_bd_port -dir O adc_valid_0]
  set adc_data_0      [create_bd_port -dir O -from 63 -to 0 adc_data_0]
  set adc_enable_1    [create_bd_port -dir O adc_enable_1]
  set adc_valid_1     [create_bd_port -dir O adc_valid_1]
  set adc_data_1      [create_bd_port -dir O -from 63 -to 0 adc_data_1]
  set adc_dwr         [create_bd_port -dir I adc_dwr]
  set adc_dsync       [create_bd_port -dir I adc_dsync]
  set adc_ddata       [create_bd_port -dir I -from 127 -to 0 adc_ddata]

  set axi_ad9144_dma_intr [create_bd_port -dir O axi_ad9144_dma_intr]
  set axi_ad9680_dma_intr [create_bd_port -dir O axi_ad9680_dma_intr]
  set axi_daq2_spi_intr   [create_bd_port -dir O axi_daq2_spi_intr  ]  
  set axi_daq2_gpio_intr  [create_bd_port -dir O axi_daq2_gpio_intr ] 

  # dac peripherals

  set axi_ad9144_core [create_bd_cell -type ip -vlnv analog.com:user:axi_ad9144:1.0 axi_ad9144_core]
  set_property -dict [list CONFIG.PCORE_QUAD_DUAL_N {0}] $axi_ad9144_core

  set axi_ad9144_jesd [create_bd_cell -type ip -vlnv xilinx.com:ip:jesd204:6.0 axi_ad9144_jesd]
  set_property -dict [list CONFIG.C_NODE_IS_TRANSMIT {1}] $axi_ad9144_jesd
  set_property -dict [list CONFIG.C_LANES {4}] $axi_ad9144_jesd

  set axi_ad9144_dma [create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9144_dma]
  set_property -dict [list CONFIG.C_DMA_TYPE_SRC {0}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_DMA_TYPE_DEST {2}] $axi_ad9144_dma
  set_property -dict [list CONFIG.PCORE_ID {1}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_AXI_SLICE_SRC {0}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_AXI_SLICE_DEST {0}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_CLKS_ASYNC_REQ_SRC {1}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_DMA_LENGTH_WIDTH {24}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_2D_TRANSFER {0}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_CYCLIC {1}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_DMA_DATA_WIDTH_SRC {128}] $axi_ad9144_dma
  set_property -dict [list CONFIG.C_DMA_DATA_WIDTH_DEST {128}] $axi_ad9144_dma


  # adc peripherals

  set axi_ad9680_core [create_bd_cell -type ip -vlnv analog.com:user:axi_ad9680:1.0 axi_ad9680_core]

  set axi_ad9680_jesd [create_bd_cell -type ip -vlnv xilinx.com:ip:jesd204:6.0 axi_ad9680_jesd]
  set_property -dict [list CONFIG.C_NODE_IS_TRANSMIT {0}] $axi_ad9680_jesd
  set_property -dict [list CONFIG.C_LANES {4}] $axi_ad9680_jesd

  set axi_ad9680_dma [create_bd_cell -type ip -vlnv analog.com:user:axi_dmac:1.0 axi_ad9680_dma]
  set_property -dict [list CONFIG.C_DMA_TYPE_SRC {1}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_DMA_TYPE_DEST {0}] $axi_ad9680_dma
  set_property -dict [list CONFIG.PCORE_ID {0}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_AXI_SLICE_SRC {0}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_AXI_SLICE_DEST {0}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_CLKS_ASYNC_DEST_REQ {1}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_SYNC_TRANSFER_START {1}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_DMA_LENGTH_WIDTH {24}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_2D_TRANSFER {0}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_CYCLIC {0}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_DMA_DATA_WIDTH_SRC {64}] $axi_ad9680_dma
  set_property -dict [list CONFIG.C_DMA_DATA_WIDTH_DEST {64}] $axi_ad9680_dma


  # dac/adc common gt/gpio

  set axi_daq2_gt [create_bd_cell -type ip -vlnv analog.com:user:axi_jesd_gt:1.0 axi_daq2_gt]
  set_property -dict [list CONFIG.PCORE_NUM_OF_TX_LANES {4}] $axi_daq2_gt
  set_property -dict [list CONFIG.PCORE_NUM_OF_RX_LANES {4}] $axi_daq2_gt
  set_property -dict [list CONFIG.PCORE_TX_LANE_SEL_0 {0}] $axi_daq2_gt
  set_property -dict [list CONFIG.PCORE_TX_LANE_SEL_1 {3}] $axi_daq2_gt
  set_property -dict [list CONFIG.PCORE_TX_LANE_SEL_2 {1}] $axi_daq2_gt
  set_property -dict [list CONFIG.PCORE_TX_LANE_SEL_3 {2}] $axi_daq2_gt

  # gpio and spi

if {$sys_zynq == 0} {

  set axi_daq2_spi [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_daq2_spi]
  set_property -dict [list CONFIG.C_USE_STARTUP {0}] $axi_daq2_spi
  set_property -dict [list CONFIG.C_NUM_SS_BITS {3}] $axi_daq2_spi
  set_property -dict [list CONFIG.C_SCK_RATIO {8}] $axi_daq2_spi

  set axi_daq2_gpio [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_daq2_gpio]
  set_property -dict [list CONFIG.C_IS_DUAL {1}] $axi_daq2_gpio
  set_property -dict [list CONFIG.C_GPIO_WIDTH {5}] $axi_daq2_gpio
  set_property -dict [list CONFIG.C_GPIO2_WIDTH {6}] $axi_daq2_gpio
  set_property -dict [list CONFIG.C_INTERRUPT_PRESENT {1}] $axi_daq2_gpio
}

if {$sys_zynq == 1} {

  set_property -dict [list CONFIG.PCW_USE_S_AXI_HP1 {1}] $sys_ps7
  set_property -dict [list CONFIG.PCW_USE_S_AXI_HP2 {1}] $sys_ps7
  set_property -dict [list CONFIG.PCW_USE_S_AXI_HP3 {1}] $sys_ps7
  set_property -dict [list CONFIG.PCW_EN_CLK2_PORT {1}] $sys_ps7
  set_property -dict [list CONFIG.PCW_EN_RST2_PORT {1}] $sys_ps7
  set_property -dict [list CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200.0}] $sys_ps7
  set_property -dict [list CONFIG.PCW_GPIO_EMIO_GPIO_IO {44}] $sys_ps7
  set_property -dict [list CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1}] $sys_ps7
  set_property -dict [list CONFIG.PCW_SPI0_SPI0_IO {EMIO}] $sys_ps7

  set_property LEFT 43 [get_bd_ports GPIO_I]
  set_property LEFT 43 [get_bd_ports GPIO_O]
  set_property LEFT 43 [get_bd_ports GPIO_T]
}

  # connections (spi and gpio)

if {$sys_zynq == 0} {

  ad_connect  spi_csn_i   axi_daq2_spi/ss_i
  ad_connect  spi_csn_o   axi_daq2_spi/ss_o
  ad_connect  spi_clk_i   axi_daq2_spi/sck_i
  ad_connect  spi_clk_o   axi_daq2_spi/sck_o
  ad_connect  spi_sdo_i   axi_daq2_spi/io0_i
  ad_connect  spi_sdo_o   axi_daq2_spi/io0_o
  ad_connect  spi_sdi_i   axi_daq2_spi/io1_i

} else {

  ad_connect  spi_csn_2_o   sys_ps7/SPI0_SS2_O
  ad_connect  spi_csn_1_o   sys_ps7/SPI0_SS1_O
  ad_connect  spi_csn_0_o   sys_ps7/SPI0_SS_O
  ad_connect  spi_csn_i     sys_ps7/SPI0_SS_I
  ad_connect  spi_clk_i     sys_ps7/SPI0_SCLK_I
  ad_connect  spi_clk_o     sys_ps7/SPI0_SCLK_O
  ad_connect  spi_sdo_i     sys_ps7/SPI0_MOSI_I
  ad_connect  spi_sdo_o     sys_ps7/SPI0_MOSI_O
  ad_connect  spi_sdi_i     sys_ps7/SPI0_MISO_I
}

if {$sys_zynq == 0} {

  ad_connect  gpio_status_i axi_daq2_gpio/gpio_io_i   
  ad_connect  gpio_status_o axi_daq2_gpio/gpio_io_o   
  ad_connect  gpio_status_t axi_daq2_gpio/gpio_io_t   
  ad_connect  gpio_ctl_i axi_daq2_gpio/gpio2_io_i  
  ad_connect  gpio_ctl_o axi_daq2_gpio/gpio2_io_o  
  ad_connect  gpio_ctl_t axi_daq2_gpio/gpio2_io_t  
}

  # connections (gt)

  ad_connect  axi_daq2_gt/ref_clk_q rx_ref_clk   
  ad_connect  axi_daq2_gt/ref_clk_c tx_ref_clk   
  ad_connect  axi_daq2_gt/rx_data_p rx_data_p   
  ad_connect  axi_daq2_gt/rx_data_n rx_data_n   
  ad_connect  axi_daq2_gt/rx_sync rx_sync   
  ad_connect  axi_daq2_gt/rx_ext_sysref rx_sysref   
  ad_connect  axi_daq2_gt/tx_data_p tx_data_p   
  ad_connect  axi_daq2_gt/tx_data_n tx_data_n   
  ad_connect  axi_daq2_gt/tx_sync tx_sync   
  ad_connect  axi_daq2_gt/tx_ext_sysref tx_sysref   

  # connections (dac)

  ad_connect  axi_daq2_gt/tx_clk_g dac_clk
  ad_connect  axi_daq2_gt/tx_clk_g axi_daq2_gt/tx_clk
  ad_connect  axi_daq2_gt/tx_clk_g axi_ad9144_core/tx_clk
  ad_connect  axi_daq2_gt/tx_clk_g axi_ad9144_jesd/tx_core_clk
  ad_connect  axi_daq2_gt/tx_rst axi_ad9144_jesd/tx_reset
  ad_connect  axi_daq2_gt/tx_sysref axi_ad9144_jesd/tx_sysref

  create_bd_cell -type ip -vlnv analog.com:user:util_ccat:1.0 util_ccat_tx_gt_charisk
  set_property -dict [list CONFIG.CH_DW {4}] [get_bd_cells util_ccat_tx_gt_charisk]
  set_property -dict [list CONFIG.CH_CNT {4}] [get_bd_cells util_ccat_tx_gt_charisk]

  ad_connect  util_ccat_tx_gt_charisk/ccat_data axi_daq2_gt/tx_gt_charisk     
  ad_connect  util_ccat_tx_gt_charisk/data_0 axi_ad9144_jesd/gt0_txcharisk 
  ad_connect  util_ccat_tx_gt_charisk/data_1 axi_ad9144_jesd/gt1_txcharisk 
  ad_connect  util_ccat_tx_gt_charisk/data_2 axi_ad9144_jesd/gt2_txcharisk 
  ad_connect  util_ccat_tx_gt_charisk/data_3 axi_ad9144_jesd/gt3_txcharisk 

  create_bd_cell -type ip -vlnv analog.com:user:util_ccat:1.0 util_ccat_tx_gt_data
  set_property -dict [list CONFIG.CH_DW {32}] [get_bd_cells util_ccat_tx_gt_data]
  set_property -dict [list CONFIG.CH_CNT {4}] [get_bd_cells util_ccat_tx_gt_data]

  ad_connect  util_ccat_tx_gt_data/ccat_data axi_daq2_gt/tx_gt_data     
  ad_connect  util_ccat_tx_gt_data/data_0 axi_ad9144_jesd/gt0_txdata 
  ad_connect  util_ccat_tx_gt_data/data_1 axi_ad9144_jesd/gt1_txdata 
  ad_connect  util_ccat_tx_gt_data/data_2 axi_ad9144_jesd/gt2_txdata 
  ad_connect  util_ccat_tx_gt_data/data_3 axi_ad9144_jesd/gt3_txdata 

  ad_connect  axi_daq2_gt/tx_rst_done axi_ad9144_jesd/tx_reset_done
  ad_connect  axi_daq2_gt/tx_ip_sync axi_ad9144_jesd/tx_sync
  ad_connect  axi_daq2_gt/tx_ip_sof axi_ad9144_jesd/tx_start_of_frame
  ad_connect  axi_daq2_gt/tx_ip_data axi_ad9144_jesd/tx_tdata
  ad_connect  axi_daq2_gt/tx_data axi_ad9144_core/tx_data
  ad_connect  axi_ad9144_core/dac_clk axi_ad9144_dma/fifo_rd_clk
  ad_connect  axi_ad9144_core/dac_valid_0 dac_valid_0  
  ad_connect  axi_ad9144_core/dac_enable_0 dac_enable_0
  ad_connect  axi_ad9144_core/dac_ddata_0 dac_ddata_0
  ad_connect  axi_ad9144_core/dac_valid_1 dac_valid_1
  ad_connect  axi_ad9144_core/dac_enable_1 dac_enable_1
  ad_connect  axi_ad9144_core/dac_ddata_1 dac_ddata_1
  ad_connect  axi_ad9144_core/dac_valid_2 dac_valid_2
  ad_connect  axi_ad9144_core/dac_enable_2 dac_enable_2
  ad_connect  axi_ad9144_core/dac_ddata_2 dac_ddata_2
  ad_connect  axi_ad9144_core/dac_valid_3 dac_valid_3
  ad_connect  axi_ad9144_core/dac_enable_3 dac_enable_3
  ad_connect  axi_ad9144_core/dac_ddata_3 dac_ddata_3
  ad_connect  dac_drd axi_ad9144_dma/fifo_rd_en
  ad_connect  dac_ddata axi_ad9144_dma/fifo_rd_dout
  ad_connect  axi_ad9144_core/dac_dunf axi_ad9144_dma/fifo_rd_underflow
  ad_connect  axi_ad9144_dma_intr axi_ad9144_dma/irq             

  # connections (adc)

  ad_connect  axi_daq2_gt/rx_clk_g adc_clk
  ad_connect  axi_daq2_gt/rx_clk_g axi_daq2_gt/rx_clk
  ad_connect  axi_daq2_gt/rx_clk_g axi_ad9680_core/rx_clk
  ad_connect  axi_daq2_gt/rx_clk_g axi_ad9680_jesd/rx_core_clk
  ad_connect  axi_daq2_gt/rx_rst axi_ad9680_jesd/rx_reset
  ad_connect  axi_daq2_gt/rx_sysref axi_ad9680_jesd/rx_sysref

  create_bd_cell -type ip -vlnv analog.com:user:util_bsplit:1.0 util_bsplit_rx_gt_charisk
  set_property -dict [list CONFIG.CH_DW {4}] [get_bd_cells util_bsplit_rx_gt_charisk]
  set_property -dict [list CONFIG.CH_CNT {4}] [get_bd_cells util_bsplit_rx_gt_charisk]

  ad_connect  util_bsplit_rx_gt_charisk/data axi_daq2_gt/rx_gt_charisk
  ad_connect  util_bsplit_rx_gt_charisk/split_data_0 axi_ad9680_jesd/gt0_rxcharisk
  ad_connect  util_bsplit_rx_gt_charisk/split_data_1 axi_ad9680_jesd/gt1_rxcharisk
  ad_connect  util_bsplit_rx_gt_charisk/split_data_2 axi_ad9680_jesd/gt2_rxcharisk
  ad_connect  util_bsplit_rx_gt_charisk/split_data_3 axi_ad9680_jesd/gt3_rxcharisk

  create_bd_cell -type ip -vlnv analog.com:user:util_bsplit:1.0 util_bsplit_rx_gt_disperr
  set_property -dict [list CONFIG.CH_DW {4}] [get_bd_cells util_bsplit_rx_gt_disperr]
  set_property -dict [list CONFIG.CH_CNT {4}] [get_bd_cells util_bsplit_rx_gt_disperr]

  ad_connect  util_bsplit_rx_gt_disperr/data axi_daq2_gt/rx_gt_disperr
  ad_connect  util_bsplit_rx_gt_disperr/split_data_0 axi_ad9680_jesd/gt0_rxdisperr
  ad_connect  util_bsplit_rx_gt_disperr/split_data_1 axi_ad9680_jesd/gt1_rxdisperr
  ad_connect  util_bsplit_rx_gt_disperr/split_data_2 axi_ad9680_jesd/gt2_rxdisperr
  ad_connect  util_bsplit_rx_gt_disperr/split_data_3 axi_ad9680_jesd/gt3_rxdisperr

  create_bd_cell -type ip -vlnv analog.com:user:util_bsplit:1.0 util_bsplit_rx_gt_notintable
  set_property -dict [list CONFIG.CH_DW {4}] [get_bd_cells util_bsplit_rx_gt_notintable]
  set_property -dict [list CONFIG.CH_CNT {4}] [get_bd_cells util_bsplit_rx_gt_notintable]

  ad_connect  util_bsplit_rx_gt_notintable/data axi_daq2_gt/rx_gt_notintable
  ad_connect  util_bsplit_rx_gt_notintable/split_data_0 axi_ad9680_jesd/gt0_rxnotintable
  ad_connect  util_bsplit_rx_gt_notintable/split_data_1 axi_ad9680_jesd/gt1_rxnotintable
  ad_connect  util_bsplit_rx_gt_notintable/split_data_2 axi_ad9680_jesd/gt2_rxnotintable
  ad_connect  util_bsplit_rx_gt_notintable/split_data_3 axi_ad9680_jesd/gt3_rxnotintable

  create_bd_cell -type ip -vlnv analog.com:user:util_bsplit:1.0 util_bsplit_rx_gt_data
  set_property -dict [list CONFIG.CH_DW {32}] [get_bd_cells util_bsplit_rx_gt_data]
  set_property -dict [list CONFIG.CH_CNT {4}] [get_bd_cells util_bsplit_rx_gt_data]

  ad_connect  util_bsplit_rx_gt_data/data axi_daq2_gt/rx_gt_data
  ad_connect  util_bsplit_rx_gt_data/split_data_0 axi_ad9680_jesd/gt0_rxdata
  ad_connect  util_bsplit_rx_gt_data/split_data_1 axi_ad9680_jesd/gt1_rxdata
  ad_connect  util_bsplit_rx_gt_data/split_data_2 axi_ad9680_jesd/gt2_rxdata
  ad_connect  util_bsplit_rx_gt_data/split_data_3 axi_ad9680_jesd/gt3_rxdata

  ad_connect  axi_daq2_gt/rx_rst_done axi_ad9680_jesd/rx_reset_done
  ad_connect  axi_daq2_gt/rx_ip_comma_align axi_ad9680_jesd/rxencommaalign_out
  ad_connect  axi_daq2_gt/rx_ip_sync axi_ad9680_jesd/rx_sync
  ad_connect  axi_daq2_gt/rx_ip_sof axi_ad9680_jesd/rx_start_of_frame
  ad_connect  axi_daq2_gt/rx_ip_data axi_ad9680_jesd/rx_tdata
  ad_connect  axi_daq2_gt/rx_data axi_ad9680_core/rx_data
  ad_connect  axi_ad9680_core/adc_enable_0 adc_enable_0
  ad_connect  axi_ad9680_core/adc_valid_0 adc_valid_0
  ad_connect  axi_ad9680_core/adc_data_0 adc_data_0
  ad_connect  axi_ad9680_core/adc_enable_1 adc_enable_1
  ad_connect  axi_ad9680_core/adc_valid_1 adc_valid_1
  ad_connect  axi_ad9680_core/adc_data_1 adc_data_1
  ad_connect  axi_daq2_gt/rx_rst axi_ad9680_fifo/adc_rst        
  ad_connect  axi_ad9680_core/adc_clk axi_ad9680_fifo/adc_clk
  ad_connect  axi_ad9680_core/adc_dovf axi_ad9680_fifo/adc_wovf
  ad_connect  adc_dwr axi_ad9680_fifo/adc_wr
  ad_connect  adc_ddata axi_ad9680_fifo/adc_wdata
  ad_connect  sys_cpu_clk axi_ad9680_fifo/dma_clk        
  ad_connect  sys_cpu_clk axi_ad9680_dma/s_axis_aclk
  ad_connect  axi_ad9680_fifo/dma_wr axi_ad9680_dma/s_axis_valid
  ad_connect  axi_ad9680_fifo/dma_wdata axi_ad9680_dma/s_axis_data
  ad_connect  axi_ad9680_fifo/dma_wready axi_ad9680_dma/s_axis_ready
  ad_connect  axi_ad9680_fifo/dma_xfer_req axi_ad9680_dma/s_axis_xfer_req
  ad_connect  axi_ad9680_dma_intr axi_ad9680_dma/irq             

  # interconnect (cpu)

  ad_cpu_interconnect 0x44A60000 axi_daq2_gt
  ad_cpu_interconnect 0x44A00000 axi_ad9144_core
  ad_cpu_interconnect 0x44A90000 axi_ad9144_jesd
  ad_cpu_interconnect 0x7c420000 axi_ad9144_dma
  ad_cpu_interconnect 0x44A10000 axi_ad9680_core
  ad_cpu_interconnect 0x44A91000 axi_ad9680_jesd
  ad_cpu_interconnect 0x7c400000 axi_ad9680_dma

if {$sys_zynq == 0} {

  ad_cpu_interconnect 0x40000000 axi_daq2_gpio
  ad_cpu_interconnect 0x44A70000 axi_daq2_spi

  ad_connect  sys_cpu_clk axi_daq2_spi/ext_spi_clk 
  ad_connect  axi_daq2_spi_intr axi_daq2_spi/ip2intc_irpt    
  ad_connect  axi_daq2_gpio_intr axi_daq2_gpio/ip2intc_irpt   
}

  # gt uses hp3, and 100MHz clock for both DRP and AXI4

  ad_mem_hp3_interconnect sys_cpu_clk sys_ps7/S_AXI_HP3
  ad_mem_hp3_interconnect sys_cpu_clk axi_daq2_gt/m_axi

  ad_connect  sys_cpu_resetn axi_daq2_gt/m_axi_aresetn 
  ad_connect  sys_cpu_clk axi_daq2_gt/drp_clk

  # interconnect (mem/dac)

  ad_mem_hp1_interconnect sys_cpu_clk sys_ps7/S_AXI_HP1
  ad_mem_hp1_interconnect sys_cpu_clk axi_ad9144_dma/m_src_axi
  ad_mem_hp2_interconnect sys_cpu_clk sys_ps7/S_AXI_HP2
  ad_mem_hp2_interconnect sys_cpu_clk axi_ad9680_dma/m_dest_axi

  # ila

  set ila_jesd_rx_mon [create_bd_cell -type ip -vlnv xilinx.com:ip:ila:5.0 ila_jesd_rx_mon]
  set_property -dict [list CONFIG.C_MONITOR_TYPE {Native}] $ila_jesd_rx_mon
  set_property -dict [list CONFIG.C_NUM_OF_PROBES {1}] $ila_jesd_rx_mon
  set_property -dict [list CONFIG.C_PROBE0_WIDTH {128}] $ila_jesd_rx_mon

  ad_connect  adc_clk ila_jesd_rx_mon/CLK
  ad_connect  adc_ddata ila_jesd_rx_mon/PROBE0



