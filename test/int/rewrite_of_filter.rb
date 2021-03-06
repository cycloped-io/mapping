require 'bundler/setup'
require 'rr'
require 'cycr'
require 'cyclopedio/mapping/filter/rewrite_of_filter'

module Cyclopedio
  module Mapping
    module Filter
      describe RewriteOfFilter do
        subject               { RewriteOfFilter.new(cyc: cyc) }
        let(:cyc)             { Cyc::Client.new(host: ENV['CYC_HOST'] || "localhost") }

        it "should filter terms that do not correspond to nouns" do
          name_service = Cyc::Service::NameService.new(cyc)
          term_newborn1 = name_service.find_by_id("Mx8Ngh4rFtoVcqy4EdeWtwACs1uxFx4rIcwFloGUQdeMlsOWYLFB2w") # #$NewbornFn #$HomoSapiens
          term_newborn2 = name_service.find_by_id("Mx4rwQtqmpwpEbGdrcN5Y29ycA") # NewbornBaby
          subject.apply([term_newborn1,term_newborn2]).should == [term_newborn2]
        end
      end
    end
  end

end

