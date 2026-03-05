require 'rails_helper'

RSpec.describe Beach, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      beach = Beach.new(
        name: 'Praia Teste',
        latitude: -23.0128,
        longitude: -43.3089,
        difficulty_level: 'beginner'
      )
      expect(beach).to be_valid
    end
    
    it 'is not valid without a name' do
      beach = Beach.new(
        latitude: -23.0128,
        longitude: -43.3089,
        difficulty_level: 'beginner'
      )
      expect(beach).to_not be_valid
    end
    
    it 'is not valid without latitude' do
      beach = Beach.new(
        name: 'Praia Teste',
        longitude: -43.3089,
        difficulty_level: 'beginner'
      )
      expect(beach).to_not be_valid
    end
    
    it 'is not valid without longitude' do
      beach = Beach.new(
        name: 'Praia Teste',
        latitude: -23.0128,
        difficulty_level: 'beginner'
      )
      expect(beach).to_not be_valid
    end
    
    it 'is not valid with invalid difficulty_level' do
      beach = Beach.new(
        name: 'Praia Teste',
        latitude: -23.0128,
        longitude: -43.3089,
        difficulty_level: 'expert'
      )
      expect(beach).to_not be_valid
    end
  end
  
  describe 'associations' do
    it 'has many surf_conditions' do
      association = described_class.reflect_on_association(:surf_conditions)
      expect(association.macro).to eq :has_many
    end
  end
  
  describe '#distance_from' do
    let(:beach) do
      Beach.create!(
        name: 'Praia Teste',
        latitude: -23.0128,
        longitude: -43.3089,
        difficulty_level: 'beginner'
      )
    end
    
    it 'calculates distance from a point' do
      # Ponto próximo (Rio de Janeiro)
      distance = beach.distance_from(-22.9068, -43.1729)
      expect(distance).to be_a(Float)
      expect(distance).to be > 0
    end
  end
  
  describe '#difficulty_label' do
    it 'returns correct label for beginner' do
      beach = Beach.new(difficulty_level: 'beginner')
      expect(beach.difficulty_label).to eq('Iniciante')
    end
    
    it 'returns correct label for intermediate' do
      beach = Beach.new(difficulty_level: 'intermediate')
      expect(beach.difficulty_label).to eq('Intermediário')
    end
    
    it 'returns correct label for advanced' do
      beach = Beach.new(difficulty_level: 'advanced')
      expect(beach.difficulty_label).to eq('Avançado/Profissional')
    end
  end
end
