function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
% 循环1000次
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions
    % 根据当前epsilon预测的结果     
    predictions = (pval < epsilon);
    
    % truePositve:分类器预测是1，真实结果也是1     
    truePositve = sum((predictions==1) & (yval==1));
    % falsePositive:分类器预测是1，真实结果是0
    falsePositive = sum((predictions==1) & (yval==0));
    % 查准率    
    precision = truePositve / (truePositve+falsePositive);
    
    % trueNegative:分类器预测是0，真实结果是1     
    trueNegative = sum((predictions==0) & (yval==1));
    % 查全率     
    recall = truePositve / (truePositve+trueNegative);

    % F1 score     
    F1 = 2*(precision*recall) / (precision+recall);
    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
