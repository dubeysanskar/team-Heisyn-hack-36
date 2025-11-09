/// ats_score : "65"
/// suggestions : [{"title":"Quantify achievements","suggestion":"Add quantifiable data to your achievements, like specific numbers or percentages. For example, instead of saying 'Participated in JunkYard Competition,' you could say 'Won first place in the JunkYard Competition' or 'Secured a top 10 ranking in the JunkYard Competition.' This helps demonstrate your skills and impact more effectively."},{"title":"Use strong action verbs","suggestion":"Replace generic verbs with stronger action verbs that showcase your skills and accomplishments. For example, instead of 'Participated in Face Painting Competition,' you could say 'Led the team in Face Painting Competition,' or 'Created a winning design for the Face Painting Competition.' This makes your resume more engaging and impactful."},{"title":"Expand on your work experience","suggestion":"Provide more details about your responsibilities and accomplishments in your internship. For example, you could describe specific projects you worked on, the skills you used, and the results you achieved. This helps demonstrate your value to potential employers."},{"title":"Highlight relevant keywords","suggestion":"Make sure you use relevant keywords throughout your resume, especially in your skills and experience sections. These keywords should match the terms used in job descriptions for the roles you're interested in. This helps your resume get noticed by ATS systems and recruiters."},{"title":"Include a summary of qualifications","suggestion":"Add a summary of qualifications to the top of your resume. This should be a brief overview of your skills, experience, and qualifications that are relevant to the job you're applying for. This helps recruiters quickly understand your strengths and how you can benefit their company."},{"title":"Use a consistent format","suggestion":"Ensure that your resume is consistent in terms of formatting, fonts, and spacing. This makes your resume easier to read and visually appealing."}]
/// missing_keywords : ["Supply Chain","Inventory Management","Procurement","Logistics","Sales","Customer Service","Data Analysis","Project Management","Teamwork","Communication","Problem-Solving"]
/// missing_social_media : ["LinkedIn"]
/// industry_level_projects : ["Inventory Optimization Project","Supply Chain Analysis","Logistics Management System Implementation","Procurement Process Automation","Customer Relationship Management System Implementation"]
/// courses : [{"course":"Supply Chain Management Specialization","platform":"Coursera"},{"course":"Logistics and Supply Chain Management","platform":"Udemy"},{"course":"Inventory Management and Control","platform":"EdX"},{"course":"Procurement and Sourcing","platform":"Udacity"}]
/// recommended_jobs : ["Supply Chain Intern","Procurement Analyst","Logistics Coordinator","Inventory Management Specialist","Sales Associate","Customer Service Representative"]

class AiResumeAtsModel {
  AiResumeAtsModel({
      String? atsScore, 
      List<Suggestions>? suggestions, 
      List<String>? missingKeywords, 
      List<String>? missingSocialMedia, 
      List<String>? industryLevelProjects, 
      List<Courses>? courses, 
      List<String>? recommendedJobs,}){
    _atsScore = atsScore;
    _suggestions = suggestions;
    _missingKeywords = missingKeywords;
    _missingSocialMedia = missingSocialMedia;
    _industryLevelProjects = industryLevelProjects;
    _courses = courses;
    _recommendedJobs = recommendedJobs;
}

  AiResumeAtsModel.fromJson(dynamic json) {
    _atsScore = json['ats_score'];
    if (json['suggestions'] != null) {
      _suggestions = [];
      json['suggestions'].forEach((v) {
        _suggestions?.add(Suggestions.fromJson(v));
      });
    }
    _missingKeywords = json['missing_keywords'] != null ? json['missing_keywords'].cast<String>() : [];
    _missingSocialMedia = json['missing_social_media'] != null ? json['missing_social_media'].cast<String>() : [];
    _industryLevelProjects = json['industry_level_projects'] != null ? json['industry_level_projects'].cast<String>() : [];
    if (json['courses'] != null) {
      _courses = [];
      json['courses'].forEach((v) {
        _courses?.add(Courses.fromJson(v));
      });
    }
    _recommendedJobs = json['recommended_jobs'] != null ? json['recommended_jobs'].cast<String>() : [];
  }
  String? _atsScore;
  List<Suggestions>? _suggestions;
  List<String>? _missingKeywords;
  List<String>? _missingSocialMedia;
  List<String>? _industryLevelProjects;
  List<Courses>? _courses;
  List<String>? _recommendedJobs;
AiResumeAtsModel copyWith({  String? atsScore,
  List<Suggestions>? suggestions,
  List<String>? missingKeywords,
  List<String>? missingSocialMedia,
  List<String>? industryLevelProjects,
  List<Courses>? courses,
  List<String>? recommendedJobs,
}) => AiResumeAtsModel(  atsScore: atsScore ?? _atsScore,
  suggestions: suggestions ?? _suggestions,
  missingKeywords: missingKeywords ?? _missingKeywords,
  missingSocialMedia: missingSocialMedia ?? _missingSocialMedia,
  industryLevelProjects: industryLevelProjects ?? _industryLevelProjects,
  courses: courses ?? _courses,
  recommendedJobs: recommendedJobs ?? _recommendedJobs,
);
  String? get atsScore => _atsScore;
  List<Suggestions>? get suggestions => _suggestions;
  List<String>? get missingKeywords => _missingKeywords;
  List<String>? get missingSocialMedia => _missingSocialMedia;
  List<String>? get industryLevelProjects => _industryLevelProjects;
  List<Courses>? get courses => _courses;
  List<String>? get recommendedJobs => _recommendedJobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ats_score'] = _atsScore;
    if (_suggestions != null) {
      map['suggestions'] = _suggestions?.map((v) => v.toJson()).toList();
    }
    map['missing_keywords'] = _missingKeywords;
    map['missing_social_media'] = _missingSocialMedia;
    map['industry_level_projects'] = _industryLevelProjects;
    if (_courses != null) {
      map['courses'] = _courses?.map((v) => v.toJson()).toList();
    }
    map['recommended_jobs'] = _recommendedJobs;
    return map;
  }

}

/// course : "Supply Chain Management Specialization"
/// platform : "Coursera"

class Courses {
  Courses({
      String? course, 
      String? platform,}){
    _course = course;
    _platform = platform;
}

  Courses.fromJson(dynamic json) {
    _course = json['course'];
    _platform = json['platform'];
  }
  String? _course;
  String? _platform;
Courses copyWith({  String? course,
  String? platform,
}) => Courses(  course: course ?? _course,
  platform: platform ?? _platform,
);
  String? get course => _course;
  String? get platform => _platform;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['course'] = _course;
    map['platform'] = _platform;
    return map;
  }

}

/// title : "Quantify achievements"
/// suggestion : "Add quantifiable data to your achievements, like specific numbers or percentages. For example, instead of saying 'Participated in JunkYard Competition,' you could say 'Won first place in the JunkYard Competition' or 'Secured a top 10 ranking in the JunkYard Competition.' This helps demonstrate your skills and impact more effectively."

class Suggestions {
  Suggestions({
      String? title, 
      String? suggestion,}){
    _title = title;
    _suggestion = suggestion;
}

  Suggestions.fromJson(dynamic json) {
    _title = json['title'];
    _suggestion = json['suggestion'];
  }
  String? _title;
  String? _suggestion;
Suggestions copyWith({  String? title,
  String? suggestion,
}) => Suggestions(  title: title ?? _title,
  suggestion: suggestion ?? _suggestion,
);
  String? get title => _title;
  String? get suggestion => _suggestion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['suggestion'] = _suggestion;
    return map;
  }

}