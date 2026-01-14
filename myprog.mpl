take begin

    here num: x ^^
    here num: y ^^

    x = 5 ^^
    y = 10 ^^

    cycle (x bigger 0) begin
        x = x - 1 ^^

        ? (x bigger 2) begin
            y = y + 1 ^^
        end
        ! begin
            y = y - 1 ^^
        end
    end

end done

