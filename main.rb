require './genotype'
require './linear_ordering'
require './tournament_parent_selection'
require './linear_ordering'
require './multi_point_crossover'
require './fitness_based_selection'
require './swap_mutation'
require './roulette_parent_selection'

input_array = ARGV
#name_input_file = input_array[0]
probability = [25,50,75]
population_size = [100,500,1000]
#num_of_random_elections = input_array[3].to_i
max_iterations = [500,1000,10000]
parent_selection = ["roulette", 'tournament']
#output_file_name = input_array[6].to_s


archivos = ["N-r100a2", "N-stabu3_250", "N-t1d500.10", "N-t1d500.25", "N-t65f11xx_250"]

for arch in archivos
	resultados = []
	values = []
	for prob in probability
		for parent in parent_selection
			for pop in population_size
				for iter in max_iterations
					
					original_matrix = File.readlines(arch).map do |line|
					  line.split.map(&:to_i)
					end
					
					num_of_random_elections = (pop*30)/100
					original_matrix.delete_at(0) #porque lee en primer lugar la dimension de la matriz pero no lo uso

					resultado = []

					tournament_selection =  TournamentParentSelection.new(num_of_random_elections: num_of_random_elections, original_matrix: original_matrix)
					roulette_selection = RouletteParentSelection.new(original_matrix:original_matrix)
					selection_criteria = (parent.downcase == 'tournament') ? tournament_selection : roulette_selection
					crossover_criteria = MultiPointCrossover.new(matrix:original_matrix)
					survivor_criteria = FitnessBasedSelection.new
					mutation_criteria = SwapMutation.new(prob)
					linearOrdering = LinearOrderingSolutionsGenerator.new(population_size: pop, original_matrix:original_matrix, max_iterations:iter, parent_selection_criteria:selection_criteria, crossover_criteria:crossover_criteria, mutation_criteria: mutation_criteria, survivor_criteria: survivor_criteria )
					solution = linearOrdering.generate_solution

					start = Time.now
					matrix = solution.create_permuted_matrix(original_matrix)
					tiempo_milisec = (Time.now - start) * 1000
					fitnessValue = solution.fitness_value
								# OUTPUT
					output = File.open( arch + '_resultados', "w" )			
					output << "probability to mutate: #{prob}, parent selection: #{parent}, population size: #{pop}, iterations: #{iter}" + "\n"
					output << "fitness value:"  + "\n"
					output << fitnessValue.to_s  + "\n"
					output << "permutation:"  + "\n"
					output << solution.permutations.to_s + "\n"
					output << "tiempo"
					output << tiempo_milisec.to_s + "\n"
					output << "------------------------------" + "\n" + "\n" 
					output.close
					resultado << "probability to mutate: #{prob}, parent selection: #{parent}, population size: #{pop}, iterations: #{iter}"
					resultado << fitnessValue
					resultado << tiempo_milisec
					resultado << solution.permutations
					resultados << resultado
					values << fitnessValue
				end
			end
		end
	end
	index_max = values.rindex(values.max)
	outputMax = File.open( arch + '_Max', "w" )	
	outputMax << (resultados[index_max][0]).to_s + "\n"
	outputMax << (resultados[index_max][1]).to_s + "\n"
	outputMax << (resultados[index_max][2]).to_s + "\n"
	outputMax << (resultados[index_max][3]).to_s + "\n"
	outputMax.close

end