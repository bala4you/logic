require 'test_case'

class TruthTable

  def initialize(condition_count, &decision)
    @condition_count = condition_count
    @decision = decision
  end

  def condition_identifiers
    identifier_range.take(@condition_count)
  end

  def cases
    case_numbers.map do |case_number|
      TestCase.new(case_number, @condition_count, @decision)
    end
  end

  def case_numbers
    1..2**@condition_count
  end

  def mcdc_cases
    condition_identifiers.map do |condition_identifier|
      "#{condition_identifier} => #{mcdc_cases_for(condition_identifier)}"
    end
  end

  def mcdc_cases_for(condition_identifier)
    cases.inject([]) do |mcdc_cases, test_case|
      mcdc_cases << test_case.number if test_case.is_mcdc_case_for_index?(index_of(condition_identifier))
      mcdc_cases
    end
  end

  def index_of(condition_identifier)
    identifier_range.to_a.index(condition_identifier)
  end

  def to_s
    header + formatted_cases
  end

  def header
    conditions = condition_identifiers.join(" ")
    "#{conditions.rjust(conditions.length + 4)} | output\n"
  end

  def formatted_cases
    cases.inject("") do |output, test_case|
      output += "#{test_case.number.to_s.rjust(2)}) #{test_case.conditions.join(' ')} | #{test_case.evaluate.to_s.rjust(3)}\n"
    end
  end

  def identifier_range
    'a'..'z'
  end

end
