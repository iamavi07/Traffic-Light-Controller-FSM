module traffic_light_fsm (
    input  clk,
    input  reset,
    input  ped_req,

    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,

    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green,

    output reg ped_green
);

    // -----------------------------
    // State encoding
    // -----------------------------
    parameter S_NS_GREEN  = 3'd0;
    parameter S_NS_YELLOW = 3'd1;
    parameter S_EW_GREEN  = 3'd2;
    parameter S_EW_YELLOW = 3'd3;
    parameter S_PED       = 3'd4;

    reg [2:0] state, next_state;

    // -----------------------------
    // Timing parameters
    // -----------------------------
    parameter NS_GREEN_TIME  = 5;
    parameter NS_YELLOW_TIME = 2;
    parameter EW_GREEN_TIME  = 5;
    parameter EW_YELLOW_TIME = 2;
    parameter PED_TIME       = 4;

    reg [3:0] count;

    // -----------------------------
    // State register
    // -----------------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_NS_GREEN;
            count <= 0;
        end else if (state != next_state) begin
            state <= next_state;
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end

    // -----------------------------
    // Next state logic
    // -----------------------------
    always @(*) begin
        next_state = state;

        case (state)

            S_NS_GREEN: begin
                if (count == NS_GREEN_TIME - 1)
                    next_state = S_NS_YELLOW;
            end

            S_NS_YELLOW: begin
                if (count == NS_YELLOW_TIME - 1) begin
                    if (ped_req)
                        next_state = S_PED;
                    else
                        next_state = S_EW_GREEN;
                end
            end

            S_EW_GREEN: begin
                if (count == EW_GREEN_TIME - 1)
                    next_state = S_EW_YELLOW;
            end

            S_EW_YELLOW: begin
                if (count == EW_YELLOW_TIME - 1) begin
                    if (ped_req)
                        next_state = S_PED;
                    else
                        next_state = S_NS_GREEN;
                end
            end

            S_PED: begin
                if (count == PED_TIME - 1)
                    next_state = S_NS_GREEN;
            end

            default: next_state = S_NS_GREEN;

        endcase
    end

    // -----------------------------
    // Output logic (Moore FSM)
    // -----------------------------
    always @(*) begin
        // default OFF
        ns_red = 0; ns_yellow = 0; ns_green = 0;
        ew_red = 0; ew_yellow = 0; ew_green = 0;
        ped_green = 0;

        case (state)

            S_NS_GREEN: begin
                ns_green = 1;
                ew_red   = 1;
            end

            S_NS_YELLOW: begin
                ns_yellow = 1;
                ew_red    = 1;
            end

            S_EW_GREEN: begin
                ew_green = 1;
                ns_red   = 1;
            end

            S_EW_YELLOW: begin
                ew_yellow = 1;
                ns_red    = 1;
            end

            S_PED: begin
                ped_green = 1;
                ns_red = 1;
                ew_red = 1;
            end

        endcase
    end

endmodule

