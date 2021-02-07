require 'airport'

describe Airport do
  let(:airport) { Airport.new }

  describe '#close' do
    it 'ATC can close an airport' do
      expect { airport.close }.to change { airport.status }.from("open").to("closed")
    end
  end

  describe '#open' do
    it 'ATC can open an airport' do
      airport = Airport.new
      airport.close
      expect { airport.open }.to change {airport.status }.from("closed").to("open")
    end
  end

  describe '#status' do
    it 'ATC can check the status of an airport' do
      expect(airport.status).to eq("open")
    end
  end

  describe '#capacity' do
    it 'airport has default capacity of 50' do
      expect(airport.capacity).to eq(50)
    end

    it 'airport capacity can be changed on creation' do
      airport = Airport.new(100)
      expect(airport.capacity).to eq(100)
    end

    it 'when airport receives a plane, it is stored in the airport' do
      plane = double("plane")
      expect { airport.receive(plane) }.to change { airport.planes.length }.from(0).to(1)
    end

    context 'when airport is full' do
      it 'airport is automatically closed' do
        plane = double("plane")
        airport = Airport.new(1)
        expect { airport.receive(plane) }.to change { airport.status }.from("open").to("closed")
      end
    end
  end
end
