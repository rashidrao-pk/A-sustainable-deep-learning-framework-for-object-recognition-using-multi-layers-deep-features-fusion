function vecFinal= Find_Entropy(score,iterations)
 for i = 1 : iterations
      entroVec(i) = entropy(score(:,i));
  end
  [entVals, entIndx] = sort(entroVec,'descend');
  vecFinal = score(:,entIndx);
end
