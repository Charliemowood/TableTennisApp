require_relative('../models/player')
require_relative('../models/game')
require_relative('../models/organisation')
require_relative('../models/group')

codeclan = Organisation.new({
  'o_name' => 'CodeClan'
  })

codeclan.save

cohort11 = Group.new({
  'g_name' => 'Cohort 11',
  'org_id' => codeclan.id
  })

cohort12 = Group.new({
  'g_name' => 'Cohort 12',
  'org_id' => codeclan.id
  })

cohort11.save
cohort12.save

johnny = Player.new({
  'p_name' => 'Johnny',
  'primary_org_id' => codeclan.id,
  'primary_group_id' => cohort12.id
  })

richard = Player.new({
  'p_name' => 'Richard',
  'primary_org_id' => codeclan.id,
  'primary_group_id' => cohort12.id
  })

irma = Player.new({
  'p_name' => 'Irma',
  'primary_org_id' => codeclan.id,
  'primary_group_id' => cohort12.id
})

dominic = Player.new({
  'p_name' => 'Dominic',
  'primary_org_id' => codeclan.id,
  'primary_group_id' => cohort11.id
})

johnny.save
richard.save
irma.save
dominic.save

game1 = Game.new({
  'p1_id' => johnny.id,
  'p2_id' => irma.id,
  'p1_score' => 6,
  'p2_score' => 4,
  'p1_org_id' => codeclan.id,
  'p2_org_id' => codeclan.id,
  'p1_group_id' => cohort12.id,
  'p2_group_id' => cohort12.id,
  'location_id' => codeclan.id
  })
game2 = Game.new({
  'p1_id' => johnny.id,
  'p2_id' => richard.id,
  'p1_score' => 1,
  'p2_score' => 6,
  'p1_org_id' => codeclan.id,
  'p2_org_id' => codeclan.id,
  'p1_group_id' => cohort12.id,
  'p2_group_id' => cohort12.id,
  'location_id' => codeclan.id
  })
game3 = Game.new({
  'p1_id' => richard.id,
  'p2_id' => irma.id,
  'p1_score' => 13,
  'p2_score' => 21,
  'p1_org_id' => codeclan.id,
  'p2_org_id' => codeclan.id,
  'p1_group_id' => cohort12.id,
  'p2_group_id' => cohort12.id,
  'location_id' => codeclan.id
  })
game4 = Game.new({
  'p1_id' => dominic.id,
  'p2_id' => irma.id,
  'p1_score' => 21,
  'p2_score' => 14,
  'p1_org_id' => codeclan.id,
  'p2_org_id' => codeclan.id,
  'p1_group_id' => cohort11.id,
  'p2_group_id' => cohort12.id,
  'location_id' => codeclan.id
  })
game5 = Game.new({
  'p1_id' => dominic.id,
  'p2_id' => johnny.id,
  'p1_score' => 21,
  'p2_score' => 12,
  'p1_org_id' => codeclan.id,
  'p2_org_id' => codeclan.id,
  'p1_group_id' => cohort11.id,
  'p2_group_id' => cohort12.id,
  'location_id' => codeclan.id
  })
game6 = Game.new({
  'p1_id' => richard.id,
  'p2_id' => dominic.id,
  'p1_score' => 6,
  'p2_score' => 5,
  'p1_org_id' => codeclan.id,
  'p2_org_id' => codeclan.id,
  'p1_group_id' => cohort12.id,
  'p2_group_id' => cohort11.id,
  'location_id' => codeclan.id
  })
game7 = Game.new({
  'p1_id' => johnny.id,
  'p2_id' => dominic.id,
  'p1_score' => 21,
  'p2_score' => 8,
  'p1_org_id' => codeclan.id,
  'p2_org_id' => codeclan.id,
  'p1_group_id' => cohort12.id,
  'p2_group_id' => cohort11.id,
  'location_id' => codeclan.id
  })

game1.save
game2.save
game3.save
game4.save
game5.save
game6.save
game7.save
