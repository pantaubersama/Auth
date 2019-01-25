module API::V1::Dashboard::Home::Entities
  class Poll < Grape::Entity
    # nil / kosong / 3 => belum menentukan pilihan
    # 1 => jokowi
    # 2 => prabowo

    expose :teams

    private
      def teams
        result = []
        data = [ { "1" => 0 }, { "2" => 0 }, { "0" => 0 } ]
        object[:grouped].each do |k, v|
          if k == 1 || k == 2
            data.select{|d| d[k.to_s]}.last[k.to_s] = data.select{|d| d[k.to_s]}.last[k.to_s] + v
          else
            data.select{|d| d["0"]}.last["0"] = data.select{|d| d["0"]}.last["0"] + v
          end
        end
        total = data.map{|d| d.first.last}.sum
        result << team_source(data[0], total)
        result << team_source(data[1], total)
        result << team_source(data[2], total)
        result
      end

      def team_text team
        if [1, "1"].include?(team)
          "Tim Jokowi - Ma'ruf"
        elsif [2, "2"].include?(team)
          "Tim Prabowo - Sandi"
        else
          "Belum Menentukan Pilihan"
        end
      end
    
      def team_source i, total
        {
          id:     i.keys.first,
          title:  team_text(i.keys.first),
          avatar: "https://s3-ap-southeast-1.amazonaws.com/pantau-bersama/assets/teams/avatar_team_#{i.keys.first}.jpg",
          total: i.values.first,
          percentage: ((i.values.first.to_f / total) * 100).round(2)
        }
      end
  end
end