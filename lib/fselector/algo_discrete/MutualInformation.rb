#
# FSelector: a Ruby gem for feature selection and ranking
#
module FSelector
#
# Mutual Information (MI)
#
#                       P(f,c)
#     MI(f,c) = log2 -------------
#                     P(f) * P(c)
#     
#                         A * N
#             = log2 ---------------
#                     (A+B) * (A+C)
#
# ref: [A Comparative Study on Feature Selection Methods for Drug Discovery](http://pubs.acs.org/doi/abs/10.1021/ci049875d)
#
  class MutualInformation < BaseDiscrete
    # this algo outputs weight for each feature
    @algo_type = :filter_by_feature_weighting
       
    private
    
    # calculate contribution of each feature (f) for each class (k)
    def calc_contribution(f)
        each_class do |k|
        a, b, c, d = get_A(f, k), get_B(f, k), get_C(f, k), get_D(f, k)
        n = a+b+c+d
        
        s = 0.0
        x = (a+b)*(a+c)
        
        s = Math.log2(a*n/x) if not x.zero?
        
        set_feature_score(f, k, s)
      end
    end # calc_contribution
    
  end # class
  
  
  # shortcut so that you can use FSelector::MI instead of FSelector::MutualInformation
  MI = MutualInformation
  
  
end # module
