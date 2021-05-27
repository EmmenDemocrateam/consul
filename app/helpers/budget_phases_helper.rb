module BudgetPhasesHelper
  def phase_begin_date(phase)
    if phase.starts_at.present?
      "#{l(phase.starts_at.to_date)} 00:00"
    end
  end

  def phase_end_date(phase)
    if phase.ends_at.present?
      "#{l(phase.ends_at.to_date - 1)} 23:59"
    end
  end
end
