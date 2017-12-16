require './genotype'

class FitnessBasedSelection

	def select(population:)
		population.delete(Genotype.select_worst(candidates: population))#arreglar para no tener que repetir la busqueda
		population.delete(Genotype.select_worst(candidates: population))
	end
end