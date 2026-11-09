module led_button (
    input  wire pl_key,
    output wire pl_led
);
    assign pl_led = pl_key;
endmodule
