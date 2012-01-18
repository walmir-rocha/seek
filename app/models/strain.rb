class Strain < ActiveRecord::Base
  belongs_to :organism
  has_many :genotypes, :dependent => :destroy
  has_one :phenotype, :dependent => :destroy
  has_many :specimens

  named_scope :by_title

  validates_presence_of :title, :organism

  named_scope :without_default,:conditions=>{:is_dummy=>false}

  include ActsAsCachedTree

  def self.default_strain_for_organism organism
    organism = Organism.find(organism) unless organism.is_a?(Organism)
    strain = Strain.find(:first,:conditions=>{:organism_id=>organism.id,:is_dummy=>true})
    if strain.nil?
      gene = Gene.find_by_title('wild-type') || Gene.create(:title => 'wild-type')
      genotype = Genotype.new(:gene => gene)
      phenotype = Phenotype.new(:description => 'wild-type')
      strain = Strain.create :organism=>organism,:is_dummy=>true,:title=>"default",:genotypes=>[genotype],:phenotype=>phenotype
    end

    strain
  end

  #gives the long title that includes genotype and phenotype details
  def info
    genotype_detail = ''
    genotypes.each do |genotype|
      genotype_detail << genotype.modification.try(:title) + ' ' + genotype.gene.try(:title) + '; ' if genotype.gene
     end
     genotype_detail = genotype_detail.blank? ? 'wild-type' : genotype_detail
     phenotype_detail = phenotype.try(:description).blank? ? 'wild-type' : phenotype.try(:description).gsub('$$$', '; ')
     title + "(" + genotype_detail + '/' + phenotype_detail + ')'
  end

end
