class SwapMutation

	def initialize(probability_to_mutate)
		@probability_to_mutate = probability_to_mutate/100.0
	end

	def mutate(offspring:, original_matrix:)
		[mutate_chromosome(offspring[0], original_matrix), mutate_chromosome(offspring[1], original_matrix)]
	end

	def mutate_chromosome(genotype, original_matrix)
		return genotype unless mutate?
		rows = swap(genotype.rows)
		cols = swap(genotype.cols)
		Genotype.new(rows, cols, original_matrix)
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

	# def mutate?
	# 	#each element is associated with its probability
	# 	candidates = {true => @probability_to_mutate , false => (1 - @probability_to_mutate)}
  #
	# 	#at some point, convert to ccumulative probability
	# 	acc = 0
	# 	candidates.each { |e,w| candidates[e] = acc+=w }
  #
	# 	#to select an element, pick a random between 0 and 1 and find the first
	# 	#cummulative probability that's greater than the random number
	# 	r = rand
	# 	selected = candidates.find{ |e,w| w>r }
  #
	# 	selected[0]
	# end
end
