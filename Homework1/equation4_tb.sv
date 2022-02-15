module stimulus();
    logic [3:0] A;
    logic [3:0] B;
    logic [7:0] C;
    logic [7:0] Z;

    integer handle;
    integer desc;

    signedEquation dut(.A(A), .B(B), .C(C), .Z(Z));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "Z: %b\n", Z);
    end

    initial begin
        #5 A = 4'b0;
        #0 B = 4'b0;
        #0 C = 8'b0;
    end

    initial begin
        #10 A = 4'b1001;
        #0 B = 4'b0;
        #0 C = 8'b0010_1101;
    end

    initial begin
        #15 A = 4'b1101;
        #0 B = 4'b0110;
        #0 C = 8'b0011_1001;
    end

    initial begin
        #20 A = 4'b1101;
        #0 B = 4'b0110;
        #0 C = 8'b1100_1111;
    end

    initial begin
        #25 A = 4'b1111;
        #0 B = 4'b1111;
        #0 C = 8'b1111_1111;
    end

endmodule