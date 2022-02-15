module stimulus();
    logic [1:0] A;
    logic [1:0] B;
    logic [3:0] S;

    integer handle;
    integer desc;

    multiplier dut(.A(A), .B(B), .S(S));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\n", S);
    end

    initial begin
        #5 A = 2'b00;
        #0 B = 2'b00;
    end

    initial begin
        #10 A = 2'b10;
        #0 B = 2'b10;
    end

    initial begin
        #15 A = 2'b11;
        #0 B = 2'b01;
    end

    initial begin
        #20 A = 2'b00;
        #0 B = 2'b10;
    end

    initial begin
        #25 A = 2'b11;
        #0 B = 2'b11;
    end
endmodule