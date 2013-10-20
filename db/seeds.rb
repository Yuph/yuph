# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "53245324")
idea = Idea.create(name: "Yuph", mini_description: "Um ambiente em que qualquer ideia pode se tornar algo incrível.", description: "Você tem ideias o tempo todo mas sozinho não vai fazer nada com elas, né?<br>Esse prédio abandonado podia ser um museu<br>Porque não fazem uma festa com tema zumbie arminhas de água?<br>Esse pacote de bolacha podia vir com outra camada só de recheio<br>Por isso criamos um ambiente onde QUALQUER ideia pode se tornar algo incrível.<br>Acreditamos que quanto mais pessoas se encontram em torno de uma ideia e discutem sobre ela maiores vão as chances dela sair do papel. Por isso, não tenha medo de compartilhar suas ideias e projetos. Aqui é o lugar certo pra eles. <br><br>Quer um mão extra nas suas ideias, projetos ou eventos? Nós adorariamos ajudar. =]<br><br><br>Tem alguma dúvida ou sugestão?<br>Nosso fórum é exatamente pra isso.Qualquer ideia será muito bem vinda.<br><br>E se você gostou mesmo da Yuph, mas mesmo mesmo, entra em contato com a gente, estamos contratando.<br>Ah! E nosso código é aberto. Dá uma olhadinha e nos diz o que você achou.", image_file_name: "/assets/yuph.png")
idea.users << user
idea.save!
Forum.create!(idea: idea)
