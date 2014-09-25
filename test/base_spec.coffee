should = require "should"
di   = require "fugu"

describe "test base helper", ->

  describe 'test di require', ->

    it 'should return real data', ->
      base = di.require 'base'
      base.a().should.not.be.eql({
        'test1': 1,
        'test2': 2
      })

      base.a().should.be.eql({
        'data1': 1,
        'data2': 2
      })

  describe 'test di replaceDependecy', ->

    before ->
      di.replaceDependecy('db_work', 'test/db_work_spec')

    after ->
      di.resetDependecy('db_work')

    it 'should return test data', ->
      base = di.require 'base'

      base.a().should.be.eql({
        'test1': 1,
        'test2': 2
      })

      base.a().should.not.be.eql({
        'data1': 1,
        'data2': 2
      })

  describe 'test di requireWithReplace', ->

    describe "mock with object", ->
      
      it 'should return fake data', ->
        base = di.requireWithReplace('base', {b: ()-> return 'fake'})

        base.a().should.be.eql({
          'data1': 1,
          'data2': 2
        })

        base.b().should.be.eql('fake')

        base.b().should.not.be.eql('original')

      it 'should return real data', ->
        base = di.require 'base'

        base.a().should.be.eql({
          'data1': 1,
          'data2': 2
        })
        
        base.b().should.be.eql('original')

        base.b().should.not.be.eql('fake')

    describe "mock with function", ->
      
      it 'should return fake data', ->
        base = di.requireWithReplace('base', (()-> return 'fake'))

        base().should.be.eql('fake')

      it 'should return real data', ->
        base = di.require 'base'

        base.a().should.be.eql({
          'data1': 1,
          'data2': 2
        })
        
        base.b().should.be.eql('original')

        base.b().should.not.be.eql('fake')

    describe "require in context", ->
      it 'should return fake data', ->
        context = di.requireWithContext('src.context', {contextVar: 'fakedContext'})
        context().should.be.eql('fakedContext')

      it 'should return real data', ->
        context = di.require('src.context')
        context().should.be.eql({dataSting: 'one'})



        




        

