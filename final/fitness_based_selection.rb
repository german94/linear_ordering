require './genotype'

class FitnessBasedSelection

	def select(population:)
		population.delete(Genotype.select_worst(candidates: population))
		population.delete(Genotype.select_worst(candidates: population))
	end
end