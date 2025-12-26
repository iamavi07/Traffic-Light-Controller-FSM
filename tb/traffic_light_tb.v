module traffic_light_tb;

    reg clk;
    reg reset;
    reg ped_req;

    wire ns_red, ns_yellow, ns_green;
    wire ew_red, ew_yellow, ew_green;
    wire ped_green;

    traffic_light_fsm DUT (
        .clk(clk),
        .reset(reset),
        .ped_req(ped_req),

        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),

        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green),

        .ped_green(ped_green)
    );

    // clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        ped_req = 0;

        #20 reset = 0;

        // pedestrian presses button
        #60  ped_req = 1;
        #20  ped_req = 0;

        // another request later
        #120 ped_req = 1;
        #20  ped_req = 0;

        #300 $stop;
    end

endmodule

