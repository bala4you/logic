module LogicStatement
  
  def conditions
    table = []
    0.upto(2**condition_identifiers.length - 1) do |value|
      table << ("%0#{condition_identifiers.length}b" % value).split(//).map(&:to_i)
    end
    table
  end

end

module Condition

  include LogicStatement
  
  def condition_identifiers
    [text_value]
  end

  def evaluate(conditions = {})
    conditions[text_value]
  end

end

module Decision

  include LogicStatement
  
  def condition_identifiers
    elements.map(&:condition_identifiers).flatten
  end

  def evaluate(conditions = {})
    condition_1 = operand_1.evaluate(conditions)
    condition_2 = operand_2.evaluate(conditions)
    operator.apply(condition_1, condition_2)
  end

end

module NonCondition
  
  def condition_identifiers
    []
  end

end
