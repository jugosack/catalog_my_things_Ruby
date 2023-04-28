require 'json'
require_relative '../classes/label'

class LabelModel
  @file_path = './JSON/labels.json'

  def self.save(labels)
    exit if labels.empty?
    all_labels = labels.map { |label| { id: label.id, title: label.title, color: label.color } }
    File.write(@file_path, JSON.pretty_generate(all_labels))
  end

  def self.fetch
    labels = []
    if File.exist?(@file_path)
      JSON.parse(File.read(@file_path)).map do |label_hash|
        labels.push(Label.new(label_hash['title'], label_hash['color'], label_hash['id']))
      end
    end
    labels
  end
end
