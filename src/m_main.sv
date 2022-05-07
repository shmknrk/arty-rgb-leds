`timescale 1ns / 1ps

module m_main (
    input logic CLK,
    input logic RST,
    // RGB LEDs
    output logic led0_b,
    output logic led0_g,
    output logic led0_r,
    output logic led1_b,
    output logic led1_g,
    output logic led1_r,
    output logic led2_b,
    output logic led2_g,
    output logic led2_r,
    output logic led3_b,
    output logic led3_g,
    output logic led3_r
);
    logic [31:0] cnt     = 0, n_cnt;
    logic [11:0] rgb_ptn = 12'b0000_0000_0000, n_rgb_ptn;

    assign {led3_r, led2_r, led1_r, led0_r, led3_g, led2_g, led1_g, led0_g, led3_b, led2_b, led1_b, led0_b} = rgb_ptn;

    always_comb begin
        n_cnt     = cnt;
        n_rgb_ptn = rgb_ptn;
        if (cnt == 0) begin
            n_rgb_ptn = rgb_ptn + 1;
        end
        if (cnt == 19_999_999) begin
            n_cnt = 0;
        end else begin
            n_cnt = cnt + 1;
        end
    end

    always_ff @ (posedge CLK or posedge RST) begin
        if (RST) begin
            cnt     <= 0;
            rgb_ptn <= 12'b0000_0000_0000;
        end else begin
            cnt     <= n_cnt;
            rgb_ptn <= n_rgb_ptn;
        end
    end
endmodule
