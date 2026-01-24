module crc_datapath (
    input         clk,
    input         rst_n,
    input         crc_start,
    input         crc_reset,
    input  [31:0] crc_seed,
    input  [31:0] crc_data_in,
    input  [15:0] crc_len,
    output reg    crc_busy,
    output reg    crc_done,
    output reg [31:0] crc_result
);

    // Internal registers
    reg [31:0] crc_reg;
    reg [15:0] counter;

    // Simple CRC polynomial (example: CRC-32, poly = 0x04C11DB7)
    parameter POLY = 32'h04C11DB7;

    // State machine
    typedef enum reg [1:0] {
        IDLE  = 2'b00,
        RUN   = 2'b01,
        DONE  = 2'b10
    } state_t;

    state_t state;

    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= IDLE;
            crc_reg   <= 32'b0;
            counter   <= 16'b0;
            crc_busy  <= 1'b0;
            crc_done  <= 1'b0;
            crc_result<= 32'b0;
        end else begin
            case (state)
                IDLE: begin
                    crc_busy  <= 1'b0;
                    crc_done  <= 1'b0;
                    if (crc_reset) begin
                        crc_reg <= 32'b0;
                        counter <= 16'b0;
                    end else if (crc_start) begin
                        crc_reg <= crc_seed;
                        counter <= crc_len;
                        state   <= RUN;
                        crc_busy<= 1'b1;
                    end
                end

                RUN: begin
                    // Process one data word per cycle
                    integer i;
                    reg [31:0] d;
                    d = crc_data_in;
                    for (i = 0; i < 32; i = i + 1) begin
                        if ((crc_reg[31] ^ d[31-i]) == 1'b1)
                            crc_reg <= (crc_reg << 1) ^ POLY;
                        else
                            crc_reg <= (crc_reg << 1);
                    end

                    if (counter > 1) begin
                        counter <= counter - 1;
                    end else begin
                        state     <= DONE;
                        crc_busy  <= 1'b0;
                        crc_done  <= 1'b1;
                        crc_result<= crc_reg;
                    end
                end

                DONE: begin
                    // Hold result until reset or next start
                    if (crc_reset) begin
                        state    <= IDLE;
                        crc_done <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
