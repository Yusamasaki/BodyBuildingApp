module WorkoutsHelper
      
  def body_part_select(work)
    if work.body_part == '1' 
      "胸"
    elsif work.body_part == '2'
      "背中"
    elsif work.body_part == '3'
      "脚"
    elsif work.body_part == '4'
      "肩"
    elsif work.body_part == '5'
      "腕"
    elsif work.body_part == '6'
      "腹筋"
    end
  end
  
  def target_muscle(workout)
    if workout == '1' 
      "胸"
    elsif workout == '2'
      "背中"
    elsif workout == '3'
      "脚"
    elsif workout == '4'
      "肩"
    elsif workout == '5'
      "腕"
    elsif workout == '6'
      "腹筋"
    end
  end
  
  def body_part_select3
    if params[:body_part] == '1' 
      "胸"
    elsif params[:body_part] == '2'
      "背中"
    elsif params[:body_part] == '3'
      "脚"
    elsif params[:body_part] == '4'
      "肩"
    elsif params[:body_part] == '5'
      "腕"
    elsif params[:body_part] == '6'
      "腹筋"
    end
  end
  
  
  def target_muscle
    if params[:body_part] == '1' 
      @sample_array = [{id: 1, name: "大胸筋上部"}, {id: 1, name: "大胸筋中部"}, {id: 1, name: "大胸筋下部"}]
    elsif params[:body_part] == '2'
      @sample_array = [{id: 2, name: "僧帽筋上部"}, {id: 2, name: "僧帽筋中部"}, {id: 2, name: "僧帽筋下部"}, {id: 2, name: "広背筋上部"}, {id: 2, name: "広背筋下部"}]
    elsif params[:body_part] == '3'
      @sample_array = [{id: 3, name: "大腿四頭筋"}, {id: 3, name: "大腿二頭筋(ハムストリング)"}, {id: 3, name: "下腿三頭筋(ふくらはぎ)"}]
    elsif params[:body_part] == '4'
      @sample_array = [{id: 4, name: "三角筋前部"}, {id: 4, name: "三角筋側部"}, {id: 4, name: "三角筋後部"}]
    elsif params[:body_part] == '5'
      @sample_array = [{id: 5, name: "上腕三頭筋"}, {id: 5, name: "上腕二頭筋"}]
    elsif params[:body_part] == '6'
      @sample_array = [{id: 6, name: "腹横筋"}, {id: 6, name: "内腹斜筋"}, {id: 6, name: "外腹斜筋"}, {id: 6, name: "腹直筋"}]
    end
  end

end
