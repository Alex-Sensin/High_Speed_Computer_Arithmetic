module stimulus();
    logic [7:0] A;
    logic [7:0] B;
    logic [15:0] S;

    integer handle;
    integer desc;

    multiplier8 dut(.A(A), .B(B), .S(S));

    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\n", S);
    end

    initial begin
        #5 A = 8'b0000_0000;
        #0 B = 8'b0000_0000;
    end

    initial begin
        #10 A = 8'b1010_1011;
        #0 B = 8'b0000_0000;
    end

    initial begin
        #15 A = 8'b1101_1011;
        #0 B = 8'b0000_0001;
    end

    initial begin
        #20 A = 8'b0101_0110;
        #0 B = 8'b0110_1101;
    end

    initial begin
        #25 A = 8'b1111_1111;
        #0 B = 8'b1111_1111;
    end
endmodule