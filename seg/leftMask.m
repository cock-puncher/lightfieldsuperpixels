%%
%% Returns a mask for the left-side region a line splits an 
%% image of size sz into.
%%
function bwl = leftMask(line, sz)

  bwl = zeros(sz, 'logical');
  x = [line(1) line(2)];  
  y = [1 sz(1)];                  
  nPoints = max(abs(diff(x)), abs(diff(y)) ) + 1; 
  I = round(linspace(y(1), y(2), nPoints));
  J = round(linspace(x(1), x(2), nPoints));

  [K, idx] = unique(I);
  
  if(isempty(K))
    return;
  end

  % Set all pixels to the left of the line to 1 to generate the mask.
  % A for loop was found to be faster than vectorized code.
  offset = 1;
  for i = 1:length(K)
    jidx = J(I == K(i));
    bwl(K(i), 1: min( min(jidx) - offset, sz(2)) ) = 1;
  end
end
