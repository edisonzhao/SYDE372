function [ prototypes, misclass ] = SequentialClassifier( a, b, j_thres )
    prototypes = [];
    misclass = [];
    j = 1;
    
    while size(a,1) > 0 && size(b,1) > 0
        if j_thres ~= -1 && j > j_thres
            break;
        end
            
        n_aB = -1;
        n_bA = -1;
        
        AB = vertcat(a,b);
        known_AB = zeros(length(AB),1);
        predicted = zeros(size(known_AB));
        
        while n_aB ~= 0 && n_bA ~= 0
            rand_a_index = randi(size(a,1));
            rand_b_index = randi(size(b,1));

            proto_a = a(rand_a_index,:);
            proto_b = b(rand_b_index,:);
            
            known_AB(1:length(a(:,1))) = 1;
            known_AB(length(a(:,1))+1:length(known_AB)) = 2;

            for i=1:length(AB)
                predicted(i) = MED(proto_a', proto_b', AB(i,:)');
            end

            CM = confusionmat(known_AB, predicted);

            n_aB = CM(1,2);
            n_bA = CM(2,1);
        end
        prototypes = [prototypes; [proto_a proto_b]];
        misclass = [misclass; [n_aB n_bA]];

        j = j + 1;
        
        if n_aB == 0
            ind = [];
            for i=(length(a(:,1))+1):length(known_AB)
                if known_AB(i) == predicted(i)
                    ind = [ind, (i-length(a(:,1)))];
                end
            end
            b(ind, :) = [];
        end
        
        if n_bA == 0
            ind = [];
            for i=1:length(a(:,1))
                if known_AB(i) == predicted(i)
                    ind = [ind, i];
                end
            end
            a(ind, :) = [];
        end
    end
end

