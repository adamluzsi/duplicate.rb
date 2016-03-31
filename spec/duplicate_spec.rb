require 'spec_helper'
describe Duplicate do

  describe '.duplicate' do

    subject { described_class.duplicate(value) }

    context 'when value is a Object' do
      let(:value) { Object.new.tap { |s| s.instance_eval { @dog = 'bark' } } }

      it { expect(subject).to_not eq value }

      it { expect(subject.object_id).to_not eq value.object_id }

      it { expect(subject.instance_variable_get(:@dog).object_id).to_not eq value.instance_variable_get(:@dog).object_id }

    end

    context 'when value is a String' do
      let(:value) { 'hello world!' }

      it { expect(subject).to eq value }

      it { expect(subject.object_id).to_not eq value.object_id }

    end

    context 'when value is a Time' do
      let(:value) { Time.now }

      it { expect(subject).to eq value }

      it { expect(subject.object_id).to_not eq value.object_id }

    end

    context 'when value is a Date' do
      let(:value) { Date.new(2015, 1, 2) }

      it { expect(subject).to eq value }

      it { expect(subject.object_id).to_not eq value.object_id }

    end

    context 'when value is a Range' do
      let(:value) { Range.new('a', 'b') }

      it { expect(subject).to eq value }

      it { expect(subject.object_id).to_not eq value.object_id }

      it { expect(subject.first.object_id).to_not eq value.first.object_id }

    end

    context 'when value is a Struct' do
      let(:base_struct) { Struct.new(:name, :address) }

      let(:value) { base_struct.new("Dave", "123 Main") }

      it { expect(subject).to eq value }

      it { expect(subject.object_id).to_not eq value.object_id }

      it { expect(subject.first.object_id).to_not eq value.first.object_id }

    end

    context 'when value is an Array' do
      let(:value) { [1, 2, 3] }

      it { expect(subject.object_id).to_not eq value.object_id }

      it { expect(subject.length).to eq value.length }

      it { expect(subject).to eq value }
    end

    context 'when value is a Hash' do
      let(:value) { {:hello => 'world'} }

      it { expect(subject.object_id).to_not eq value.object_id }

      it { expect(subject.length).to eq value.length }

      it { expect(subject).to eq value }

      it { expect(subject[:hello].object_id).to_not eq value[:hello].object_id }
    end

    context 'when value is a Class' do

      class SampleDeepDupClass

        def self.test
          @test ||= {:dog => 'bark'}
        end

        test

      end

      let(:value) { SampleDeepDupClass }

      it { expect(subject.object_id).to_not eq value.object_id }

      it { expect(subject).to_not eq value }

      it { expect(subject.test[:dog].object_id).to_not eq value.test[:dog].object_id }

    end

    context 'when value is a Module' do

      module SampleDeepDupModule

        def self.test
          @test ||= {:dog => 'bark'}
        end

        test

      end

      let(:value) { SampleDeepDupModule }

      it { expect(subject.object_id).to_not eq value.object_id }

      it { expect(subject).to_not eq value }

      it { expect(subject.test[:dog].object_id).to_not eq value.test[:dog].object_id }

    end

    context 'when the given object is not dup-able' do

      context 'such as Symbol' do
        let(:value) { :hello }

        it { expect(subject.object_id).to eq value.object_id }
      end

      context 'such as Integer' do
        let(:value) { 123 }

        it { expect(subject.object_id).to eq value.object_id }
      end

      context 'such as Float' do
        let(:value) { 123.456 }

        it { expect(subject.object_id).to eq value.object_id }
      end

      context 'such as nil' do
        let(:value) { nil }

        it { expect(subject.object_id).to eq value.object_id }
      end

      context 'such as true' do
        let(:value) { true }

        it { expect(subject.object_id).to eq value.object_id }
      end

      context 'such as false' do
        let(:value) { false }

        it { expect(subject.object_id).to eq value.object_id }
      end

    end


    context 'when object is recurring to self' do

      let(:value) do
        h = Hash.new
        h[:self] = h
        h
      end

      it 'should dup anything that possible' do
        expect(subject.object_id).to_not eq value.object_id
      end

      it 'should not deep_ dup one object more than one time' do
        expect(subject[:self].object_id).to eq subject.object_id
      end

    end

    context 'when object is a method' do
      let(:value) do
        klass = Class.new
        klass.class_eval do
          def self.hello
            'world'
          end
        end
        klass.method(:hello)
      end

      it { is_expected.to be value }
    end

    context 'when object is a proc' do
      let(:value) { Proc.new { 'hy' } }

      it { is_expected.to be_a Proc }
      it { is_expected.to_not be value }
      it { expect(subject.call).to eq 'hy' }
    end

    context 'when basic object given' do

      let(:value) do
        bo = BasicObject.new
        bo.instance_eval { @var = 'Hello, World!' }
        bo
      end

      it { is_expected.to be value }

    end unless RUBY_VERSION =~ /^1\.8/

    context 'when object not accept instance_variable get/set' do

      let(:value) do

        c = Class.new
        c.class_eval do

          def dog
            @dog
          end

          undef :instance_variable_set
          undef :instance_variable_get

        end

        o = c.new
        o.instance_eval { @dog = 'bark' }

        o
      end

      it { is_expected.to_not be value }
      it { expect(subject.dog).to eq 'bark' }
      it { expect(subject.dog).to_not be value.dog }

    end

  end

  describe 'Object.duplicate' do
    subject{ duplicate(value) }
    let(:value){ 'Hello, world!'}
    it {is_expected.to eq value}
    it {expect(subject.object_id).to_not eq value.object_id}
  end

end