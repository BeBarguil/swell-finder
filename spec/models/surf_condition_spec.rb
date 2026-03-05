require 'rails_helper'

RSpec.describe SurfCondition, type: :model do
  let(:beach) do
    Beach.create!(
      name: 'Praia Teste',
      latitude: -23.0128,
      longitude: -43.3089,
      difficulty_level: 'beginner'
    )
  end
  
  describe 'validations' do
    it 'is valid with valid attributes' do
      condition = SurfCondition.new(
        beach: beach,
        wave_height: 1.5,
        wind_speed: 10.0
      )
      expect(condition).to be_valid
    end
    
    it 'is not valid without wave_height' do
      condition = SurfCondition.new(
        beach: beach,
        wind_speed: 10.0
      )
      expect(condition).to_not be_valid
    end
    
    it 'is not valid with negative wave_height' do
      condition = SurfCondition.new(
        beach: beach,
        wave_height: -1.0,
        wind_speed: 10.0
      )
      expect(condition).to_not be_valid
    end
  end
  
  describe 'associations' do
    it 'belongs to beach' do
      association = described_class.reflect_on_association(:beach)
      expect(association.macro).to eq :belongs_to
    end
  end
  
  describe '#good_conditions?' do
    it 'returns true for good conditions' do
      condition = SurfCondition.new(
        beach: beach,
        wave_height: 1.5,
        wind_speed: 10.0
      )
      expect(condition.good_conditions?).to be true
    end
    
    it 'returns false for flat conditions' do
      condition = SurfCondition.new(
        beach: beach,
        wave_height: 0.3,
        wind_speed: 10.0
      )
      expect(condition.good_conditions?).to be false
    end
    
    it 'returns false for strong wind' do
      condition = SurfCondition.new(
        beach: beach,
        wave_height: 1.5,
        wind_speed: 30.0
      )
      expect(condition.good_conditions?).to be false
    end
  end
  
  describe '#swell_quality' do
    it 'returns correct quality for different wave heights' do
      expect(SurfCondition.new(wave_height: 0.2).swell_quality).to eq('Sem ondas')
      expect(SurfCondition.new(wave_height: 0.4).swell_quality).to eq('Flat')
      expect(SurfCondition.new(wave_height: 0.8).swell_quality).to eq('Pequeno')
      expect(SurfCondition.new(wave_height: 1.2).swell_quality).to eq('Bom')
      expect(SurfCondition.new(wave_height: 2.0).swell_quality).to eq('Ótimo')
      expect(SurfCondition.new(wave_height: 3.0).swell_quality).to eq('Excelente')
    end
  end
  
  describe '#wind_type' do
    it 'returns correct wind type' do
      expect(SurfCondition.new(wind_speed: 3.0).wind_type).to eq('Leve')
      expect(SurfCondition.new(wind_speed: 10.0).wind_type).to eq('Moderado')
      expect(SurfCondition.new(wind_speed: 20.0).wind_type).to eq('Forte')
      expect(SurfCondition.new(wind_speed: 30.0).wind_type).to eq('Muito Forte')
    end
  end
end
