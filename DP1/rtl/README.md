# RTL Folder – AI-HDL Phase 1

This folder contains all **Verilog RTL source files** for our team’s design in the AI Hardware Design League (AI-HDL).  
The RTL implements both the **CRC MMIO peripheral** and the **CRC datapath logic**, integrated with the provided RISC-V core.

---

## 📂 Contents
- `tqvp_ingenius.v` – CRC MMIO peripheral designed by Adedotun 🌹
- `crc_datapath.v` – CRC datapath logic (initial implementation by Adedotun on behalf of Timothy)
- (to be added) Other supporting RTL modules

---

## 🧩 CRC MMIO Peripheral (`tqvp_ingenius`)
This module provides a **memory-mapped interface** between the RISC-V core and the CRC datapath.  
It defines six registers accessible by software:

| Address | Register | Description |
|---------|----------|-------------|
| 0x00    | CTRL     | Control register: bit0 = start, bit1 = reset |
| 0x04    | STATUS   | Status flags: bit0 = busy, bit1 = done |
| 0x08    | SEED     | Initial CRC seed value |
| 0x0C    | LEN      | Length of data stream (lower 16 bits used) |
| 0x10    | DATA     | Input data word |
| 0x14    | RESULT   | Final CRC result |

---

## 🔗 Datapath Interface Signals
The MMIO block connects to the CRC datapath via the following signals:

**Inputs to datapath:**
- `crc_start` – start pulse from CTRL[0]  
- `crc_reset` – reset pulse from CTRL[1]  
- `crc_seed` – seed value from SEED register  
- `crc_data_in` – input data word from DATA register  
- `crc_len` – length of data stream from LEN register  

**Outputs from datapath:**
- `crc_busy` – datapath is processing  
- `crc_done` – datapath has finished  
- `crc_result` – final CRC value  

---

## ⚙️ CRC Datapath (`crc_datapath`)
This module implements a **CRC-32 computation** using polynomial `0x04C11DB7`.  
- Processes one 32-bit word per cycle.  
- Controlled by `crc_start` and `crc_reset`.  
- Produces `crc_busy`, `crc_done`, and `crc_result` signals for MMIO integration.  
- Fully synthesizable and ready for verification.

---

## ⚙️ Integration Notes
- The MMIO peripheral is instantiated in `tt_wrapper.v` (line 41 updated to `tqvp_ingenius`).  
- All reads complete in one cycle (`data_ready = 1`).  
- `user_interrupt` is asserted when CRC computation finishes (`crc_done = 1`).  

---

## 📝 Next Steps
- **Iriamuzu**: Write testbenches in `tb/` to verify register writes/reads and CRC outputs.  
- **~.**: Run synthesis with Yosys/OpenLane and generate PPA reports.  
- **Empress~J**: Document register map and integration details in `docs/`.

---
