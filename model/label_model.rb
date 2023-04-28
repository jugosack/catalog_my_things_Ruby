class LabelModel
  def self.save(labels)
    all_labels = labels.map |label| { title: label.title, color: label.color }
    File.write('./JSON/labels.json', JSON.generate(all_labels))
  end

  def self.fetch
    labels = []
    if File.exist?('./JSON/labels.json')
      JSON.parse(File.read('./JSON/labels.json')).map do |label_hash|
        labels.push(Label.new(label_hash['title'], label_hash['color']))
      end
    end
    labels
  end
end
