namespace :my_faker_namespace do
  desc "TODO"
  task my_faker_task: :environment do
    require 'faker'
    [Category, Instruction, Step, Block, Tag, Tagging, CountLink, User].each(&:delete_all)

    Faker::Config.random = Random.new(42+7)
    MINTAGS, MAXTAGS = 25, 100
    MINTAGSININSTRUCTION, MAXTAGSININSTRUCTION = 1, 7

    MINUSERS, MAXUSERS = 5, 10
    MINCATS, MAXCATS = 3, 5
    MININSTRUCTIONS, MAXINSTRUCTIONS = 5, 7
    MINSTEPS, MAXSTEPS = 5, 10
    MINBLOCKS, MAXBLOCKS = 10, 20

    ActiveRecord::Base.transaction do

      tags_count = Faker::Number.between(MINTAGS, MAXTAGS)
      tags_list = []

      (1..tags_count).each do
        tags_list << Tag.create(name: Faker::Lorem.word)
      end

      users_count = Faker::Number.between(MINUSERS, MAXUSERS)
      users_list = []

      (1..users_count).each do
        user = User.create(
            name: Faker::Name.name,
            email: Faker::Internet.email,
            password: '123456',
            confirmed_at: DateTime.now,
            image: Faker::Avatar.image(Faker::Internet.slug, "300x300", "png"),
        )
        user.skip_confirmation!
        users_list << user
      end

      user = User.create(
          name: "VOLHA SIARKOVA",
          email: "s_o_va@tut.by",
          password: "123456",
          confirmed_at: DateTime.now,
          provider: 'vkontakte',
          uid: 6275311,
          image: 'https://pp.userapi.com/c636325/v636325311/12c5f/X94ne7LOqTQ.jpg',
          role: :admin
      )
      user.skip_confirmation!
      users_list << user

      (1..Faker::Number.between(MINCATS, MAXCATS)).each do |cat_i|
        category = Category.create(name: Faker::Lorem.word)

        (1..Faker::Number.between(MININSTRUCTIONS, MAXINSTRUCTIONS)).each do |inst_i|
          puts "#{cat_i}, #{inst_i}"

          instruction = Instruction.create(
              name: Faker::Lorem.word,
              category: category,
              user: users_list.sample(1)[0],
              created_at: Faker::Date.between(10.year.ago, Date.today),
              updated_at: Faker::Date.between(10.year.ago, Date.today),
          )

          instruction.tags = tags_list.sample(Faker::Number.between(1, [tags_count, Faker::Number.between(MINTAGSININSTRUCTION, MAXTAGSININSTRUCTION)].min ))
          CountLink.create(count: 0, instruction: instruction)

          (1..Faker::Number.between(MINSTEPS, MAXSTEPS)).each do
            step = Step.create(
                name: Faker::Lorem.word,
                instruction: instruction
            )

            (1..Faker::Number.between(MINBLOCKS, MAXBLOCKS)).each do
              block_type = Faker::Number.between(0, 2)
              body = nil
              block_type_res = nil

              if block_type == 0 # text
                body = Faker::Lorem.sentences(Faker::Number.between(4, 25))
                block_type_res = :text
              elsif block_type == 1 # image
                body = Faker::Avatar.image(Faker::Internet.slug, '300x300', 'png')
                block_type_res = :image
              elsif block_type == 2 # video
                body = 'http://res.cloudinary.com/dpoas7y00/video/upload/v1501427755/emleq7f6lkz4ij5xpfyo.mkv'
                block_type_res = :video
              end

              block = Block.create(
                  body: body,
                  block_type: block_type_res,
                  step: step,
              )
            end
          end
        end
      end
    end
  end
end
