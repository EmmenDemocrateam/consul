module CustomProposalsHelper
  def proposals_map_locations
    proposal_ids = []
    Proposal.find_each { |proposal| proposal_ids << proposal.id }

    MapLocation.where(proposal_id: proposal_ids).map { |l| l.json_data }
  end
end
