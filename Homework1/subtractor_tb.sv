module stimulus();
    logic [127:0] A;
    logic [127:0] B;
    logic [127:0] Y;

    integer handle;
    integer desc;

    subtractor dut(.A(A), .B(B), .Y(Y));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "Y: %b\n", Y);
    end

    initial begin
        #5 A = 128'h0;
        #0 B = 128'h0;
    end

    initial begin
        #10 A = 128'h4abfd25ed0ff544f206ced7b625adf9e;
        #0 B = 128'h0;
    end

    initial begin
        #15 A = 128'h5a846f993118880023326ca3f989fd16;
        #0 B = 128'h36dcf841cfd771e60ada2f2931678e34;
    end

    initial begin
        #20 A = 128'h5c999c299cebde9215a154cb8e85cb6a;
        #0 B = 128'h0a5c3cdc4a11d9f2baa6c206aa7b9201;
    end

    initial begin
        #25 A = 128'hffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff;
        #0 B = 128'hffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff;
    end

endmodule