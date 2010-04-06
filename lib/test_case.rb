require 'integer'

class TestCase

  attr_reader :conditions
  attr_reader :number
  
  def initialize(number, condition_count, decision)
    @number = number
    @conditions = create_conditions(condition_count)
    @decision = decision
  end

  def initialize_copy(source)
    super
    @conditions = conditions.dup
  end

  def create_conditions(condition_count)
    value = number - 1
    value.to_array_of_bits(condition_count)
  end

  def output
    @decision.call(@conditions)
  end

  def is_mcdc_case_for_index?(index)
    modified_case = negate_condition_at_index(index)
    modified_case.output != output
  end

  def negate_condition_at_index(index)
    dup.negate_condition_at_index!(index)
  end

  def negate_condition_at_index!(index)
    @conditions[index] = @conditions[index].negate
    self
  end

end
