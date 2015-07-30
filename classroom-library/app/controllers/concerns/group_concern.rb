module GroupConcern
  extend ActiveSupport::Concern

  included do
    helper_method :student_groups
  end

  def student_groups(group_num, grouping_method)
    num_per_group = (current_teacher.students.length)/group_num
    if grouping_method == "lexile_homo"
      students_order = current_teacher.students.reorder('lexile_level')
    # elsif grouping_method == 'lexile_hetero'
    elsif grouping_method == 'alpha_last'
      students_order = current_teacher.students.reorder('last_name')
    else
      students_order = current_teacher.students.reorder('first_name')
    end

    @student_groups = []

    group_num.times do
      @student_groups << []
    end

    count_of_student = 0
    group_num = 0

    students_order.each do |student|
      if count_of_student < num_per_group
        @student_groups[group_num] << student
        count_of_student += 1
      else
        count_of_student = 0
        group_num += 1
        @student_groups[group_num] << student
      end
    end
    return @student_groups
  end
end
