class TournamentParentSelection
  def initialize(num_of_random_elections:, original_matrix:)
    @num_of_random_elections = num_of_random_elections
    @original_matrix = original_matrix
  end

  def select(population)
    possible_parents = population.to_a.sample(@num_of_random_elections) #sample no funca con sets asi que hay que pasarlo a array
    possible_parents.inject(possible_parents.first) do |selected_parent, possible_parent|
      #quizas selected_parent_fitness_value podria declararse afuera, entonces se "cachea" y no se tiene que recalcular
      #en cada iteracion del inject, que tal vez no cambie si se encuentra el mejor al principio por ejemplo
      selected_parent_fitness_value = selected_parent.calculate_fitness_function(original_matrix)
      possible_parent_fitness_value = possible_parent.calculate_fitness_function(original_matrix)
      selected_parent_fitness_value < possible_parent_fitness_value ? possible_parent : selected_parent
  end
end
