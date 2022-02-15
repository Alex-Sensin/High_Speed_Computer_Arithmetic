module stimulus();
    logic [3:0] A;
    logic [3:0] B;
    logic [7:0] S;

    integer handle;
    integer desc;

    multiplier4 dut(.A(A), .B(B), .S(S));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\n", S);
    end

    initial begin
        #5 A = 4'b00;
        #0 B = 4'b00;
    end

    initial begin
        #10 A = 4'b0110;
        #0 B = 4'b1010;
    end

    initial begin
        #15 A = 4'b0111;
        #0 B = 4'b0001;
    end

    initial begin
        #20 A = 4'b00;
        #0 B = 4'b10;
    end

    initial begin
        #25 A = 4'b1111;
        #0 B = 4'b1111;
    end
endmodule