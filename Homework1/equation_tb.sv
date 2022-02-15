module stimulus();
    logic [63:0] A;
    logic [63:0] B;
    logic [127:0] C;
    logic [127:0] Z;

    integer handle;
    integer desc;

    equation dut(.A(A), .B(B), .C(C), .Z(Z));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "Z: %b\n", Z);
    end

    initial begin
        #5 A = 64'h0;
        #0 B = 64'h0;
        #0 C = 128'h0;
    end

    initial begin
        #10 A = 64'h9e671e3d752a5420;
        #0 B = 64'h0;
        #0 C = 128'h0026c160f19eb5f182168f26ab92c99b;
    end

    initial begin
        #15 A = 64'h98d04de49a35b97e;
        #0 B = 64'hc9a07adf5fcb76f2;
        #0 C = 128'h065443acbb9ef54db82da1dc81659de9;
    end

    initial begin
        #20 A = 64'h1c88d06749e7613b;
        #0 B = 64'hb4e6696be96117f6;
        #0 C = 128'h312caf263d7bceb6eb636bc5f2d8acff;
    end

    initial begin
        #25 A = 64'hffff_ffff_ffff_ffff;
        #0 B = 64'hffff_ffff_ffff_ffff;
        #0 C = 128'hffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff;
    end

endmodule