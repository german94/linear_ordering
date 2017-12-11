class SwapMutation

	def initialize(probability_to_mutate)
		@probability_to_mutate = probability_to_mutate/100.0
	end

	def mutate(offspring:, original_matrix:)
		[mutate_chromosome(offspring[0], original_matrix), mutate_chromosome(offspring[1], original_matrix)]
	end

	def mutate_chromosome(genotype, original_matrix)
		return genotype unless mutate?
		new_permutations = swap(genotype.permutations)
		Genotype.new(new_permutations, original_matrix)
	end

	def swap(elem)
		firstPosition = rand(0..elem.size - 1)
		secondPosition = rand(0..elem.size - 1)
		elem[firstPosition], elem[secondPosition] = elem[secondPosition], elem[firstPosition]
		elem
	end

	def mutate?
		rand < @probability_to_mutate
	end
end
