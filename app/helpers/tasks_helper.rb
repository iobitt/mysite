module TasksHelper
  def interval_formatter(interval)
    start_f = interval.start_at.strftime("%d.%m.%Y %H:%M")
    end_f = interval.end_at.strftime("%d.%m.%Y %H:%M")
    "#{start_f} - #{end_f}"
  end

  def decoration_for(interval)
    if Time.zone.now > interval.end_at
      'text-decoration-line-through'
    elsif Time.zone.now >= interval.start_at && Time.zone.now <= interval.end_at
      'fw-bold'
    else
      ''
    end
  end

  def subtask_decoration(subtask)
    subtask.completed ? 'text-success' : ''
  end

  def tag_link(tag)
    "?tag_id=#{tag.id}"
  end

  def tag_class(active_tag, tag)
    return 'active-tag' if active_tag.nil? && tag.nil?
    active_tag&.id == tag&.id ? 'active-tag' : ''
  end
end
