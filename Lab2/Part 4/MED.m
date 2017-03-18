function [ class_id ] = MED( class1, class2, x )
    val = (class2-class1)' * x + 0.5*(class1' * class1 - class2' * class2);
    if val > 0
        class_id = 1;
    else 
        class_id = 2;
    end
end

