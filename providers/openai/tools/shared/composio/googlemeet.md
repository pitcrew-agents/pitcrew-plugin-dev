# googlemeet

## GOOGLEMEET_CREATE_MEET
Creates a new Google Meet space with optional configuration. Does not attach to any calendar event — calendar linking requires a separate Calendar tool call. Capture `meetingUri`, `meetingCode`, and `space.name` from the response immediately for downstream lookups. Requires `meetings.space.created` OAuth scope. Returns HTTP 429 under rapid calls; apply exponential backoff. Use when you need a meeting space with specific access controls, moderation, recording, or transcription settings.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateMeetRequest",
  "properties": {
    "config": {
      "type": "object",
      "title": "SpaceConfig",
      "properties": {
        "accessType": {
          "enum": [
            "ACCESS_TYPE_UNSPECIFIED",
            "OPEN",
            "TRUSTED",
            "RESTRICTED"
          ],
          "type": "string",
          "title": "AccessType",
          "description": "Access type determining who can join without knocking. Default: user's default access settings or RESTRICTED."
        },
        "moderation": {
          "enum": [
            "MODERATION_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "ModerationMode",
          "description": "Pre-configured moderation mode for the meeting. Controls whether moderation features are enabled."
        },
        "artifactConfig": {
          "type": "object",
          "title": "ArtifactConfig",
          "properties": {
            "recordingConfig": {
              "type": "object",
              "title": "RecordingConfig",
              "properties": {
                "autoRecordingGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "AutoGenerationType",
                  "description": "Controls automatic recording generation. Determines if meetings are automatically recorded."
                }
              },
              "description": "Configuration for automatic recording of meetings.",
              "additionalProperties": false
            },
            "smartNotesConfig": {
              "type": "object",
              "title": "SmartNotesConfig",
              "properties": {
                "autoSmartNotesGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "AutoGenerationType",
                  "description": "Controls automatic smart notes generation. Determines if AI-generated meeting summaries are created."
                }
              },
              "description": "Configuration for automatic smart notes generation.",
              "additionalProperties": false
            },
            "transcriptionConfig": {
              "type": "object",
              "title": "TranscriptionConfig",
              "properties": {
                "autoTranscriptionGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "AutoGenerationType",
                  "description": "Controls automatic transcription generation. Determines if meeting audio is automatically transcribed."
                }
              },
              "description": "Configuration for automatic transcription of meetings.",
              "additionalProperties": false
            }
          },
          "description": "Configuration for meeting artifacts like recordings, transcriptions, and smart notes.",
          "additionalProperties": false
        },
        "entryPointAccess": {
          "enum": [
            "ENTRY_POINT_ACCESS_UNSPECIFIED",
            "ALL",
            "CREATOR_APP_ONLY"
          ],
          "type": "string",
          "title": "EntryPointAccess",
          "description": "Defines which entry points can be used to join meetings in this space. Default: ALL."
        },
        "moderationRestrictions": {
          "type": "object",
          "title": "ModerationRestrictions",
          "properties": {
            "chatRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "RestrictionType",
              "description": "Restriction level for chat functionality during moderated meetings."
            },
            "presentRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "RestrictionType",
              "description": "Restriction level for screen sharing/presenting during moderated meetings."
            },
            "reactionRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "RestrictionType",
              "description": "Restriction level for reactions during moderated meetings."
            },
            "defaultJoinAsViewerType": {
              "enum": [
                "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "DefaultJoinAsViewerType",
              "description": "Determines if participants join as viewers by default during moderated meetings."
            }
          },
          "description": "Restrictions applied to meeting features when moderation is enabled.",
          "additionalProperties": false
        },
        "attendanceReportGenerationType": {
          "enum": [
            "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
            "GENERATE_REPORT",
            "DO_NOT_GENERATE"
          ],
          "type": "string",
          "title": "AttendanceReportGenerationType",
          "description": "Controls whether attendance reports are automatically generated for meetings in this space."
        }
      },
      "description": "Optional configuration for the meeting space. If not provided, default settings will be used. Key sub-fields: `accessType` and `entryPointAccess` default to permissive values \u2014 set explicitly when audience or access level is known, as permissive defaults may conflict with organizational policies. Invalid combinations of these fields or moderation settings may be rejected based on domain/account policies. Recording and transcription features require a Workspace edition that supports cloud recording; personal accounts may not support these options.",
      "additionalProperties": false
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "AccessType": {
      "enum": [
        "ACCESS_TYPE_UNSPECIFIED",
        "OPEN",
        "TRUSTED",
        "RESTRICTED"
      ],
      "type": "string",
      "title": "AccessType"
    },
    "SpaceConfig": {
      "type": "object",
      "title": "SpaceConfig",
      "properties": {
        "accessType": {
          "enum": [
            "ACCESS_TYPE_UNSPECIFIED",
            "OPEN",
            "TRUSTED",
            "RESTRICTED"
          ],
          "type": "string",
          "title": "Access Type",
          "description": "Access type determining who can join without knocking. Default: user's default access settings or RESTRICTED."
        },
        "moderation": {
          "enum": [
            "MODERATION_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Moderation",
          "description": "Pre-configured moderation mode for the meeting. Controls whether moderation features are enabled."
        },
        "artifactConfig": {
          "type": "object",
          "title": "Artifact Config",
          "properties": {
            "recordingConfig": {
              "type": "object",
              "title": "Recording Config",
              "properties": {
                "autoRecordingGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Auto Recording Generation",
                  "description": "Controls automatic recording generation. Determines if meetings are automatically recorded."
                }
              },
              "description": "Configuration for automatic recording of meetings."
            },
            "smartNotesConfig": {
              "type": "object",
              "title": "Smart Notes Config",
              "properties": {
                "autoSmartNotesGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Auto Smart Notes Generation",
                  "description": "Controls automatic smart notes generation. Determines if AI-generated meeting summaries are created."
                }
              },
              "description": "Configuration for automatic smart notes generation."
            },
            "transcriptionConfig": {
              "type": "object",
              "title": "Transcription Config",
              "properties": {
                "autoTranscriptionGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Auto Transcription Generation",
                  "description": "Controls automatic transcription generation. Determines if meeting audio is automatically transcribed."
                }
              },
              "description": "Configuration for automatic transcription of meetings."
            }
          },
          "description": "Configuration for meeting artifacts like recordings, transcriptions, and smart notes."
        },
        "entryPointAccess": {
          "enum": [
            "ENTRY_POINT_ACCESS_UNSPECIFIED",
            "ALL",
            "CREATOR_APP_ONLY"
          ],
          "type": "string",
          "title": "Entry Point Access",
          "description": "Defines which entry points can be used to join meetings in this space. Default: ALL."
        },
        "moderationRestrictions": {
          "type": "object",
          "title": "Moderation Restrictions",
          "properties": {
            "chatRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "Chat Restriction",
              "description": "Restriction level for chat functionality during moderated meetings."
            },
            "presentRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "Present Restriction",
              "description": "Restriction level for screen sharing/presenting during moderated meetings."
            },
            "reactionRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "Reaction Restriction",
              "description": "Restriction level for reactions during moderated meetings."
            },
            "defaultJoinAsViewerType": {
              "enum": [
                "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Default Join As Viewer Type",
              "description": "Determines if participants join as viewers by default during moderated meetings."
            }
          },
          "description": "Restrictions applied to meeting features when moderation is enabled."
        },
        "attendanceReportGenerationType": {
          "enum": [
            "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
            "GENERATE_REPORT",
            "DO_NOT_GENERATE"
          ],
          "type": "string",
          "title": "Attendance Report Generation Type",
          "description": "Controls whether attendance reports are automatically generated for meetings in this space."
        }
      }
    },
    "ArtifactConfig": {
      "type": "object",
      "title": "ArtifactConfig",
      "properties": {
        "recordingConfig": {
          "type": "object",
          "title": "Recording Config",
          "properties": {
            "autoRecordingGeneration": {
              "enum": [
                "AUTO_GENERATION_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Auto Recording Generation",
              "description": "Controls automatic recording generation. Determines if meetings are automatically recorded."
            }
          },
          "description": "Configuration for automatic recording of meetings."
        },
        "smartNotesConfig": {
          "type": "object",
          "title": "Smart Notes Config",
          "properties": {
            "autoSmartNotesGeneration": {
              "enum": [
                "AUTO_GENERATION_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Auto Smart Notes Generation",
              "description": "Controls automatic smart notes generation. Determines if AI-generated meeting summaries are created."
            }
          },
          "description": "Configuration for automatic smart notes generation."
        },
        "transcriptionConfig": {
          "type": "object",
          "title": "Transcription Config",
          "properties": {
            "autoTranscriptionGeneration": {
              "enum": [
                "AUTO_GENERATION_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Auto Transcription Generation",
              "description": "Controls automatic transcription generation. Determines if meeting audio is automatically transcribed."
            }
          },
          "description": "Configuration for automatic transcription of meetings."
        }
      }
    },
    "ModerationMode": {
      "enum": [
        "MODERATION_UNSPECIFIED",
        "OFF",
        "ON"
      ],
      "type": "string",
      "title": "ModerationMode"
    },
    "RecordingConfig": {
      "type": "object",
      "title": "RecordingConfig",
      "properties": {
        "autoRecordingGeneration": {
          "enum": [
            "AUTO_GENERATION_TYPE_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Auto Recording Generation",
          "description": "Controls automatic recording generation. Determines if meetings are automatically recorded."
        }
      }
    },
    "RestrictionType": {
      "enum": [
        "RESTRICTION_TYPE_UNSPECIFIED",
        "NO_RESTRICTION",
        "HOSTS_ONLY"
      ],
      "type": "string",
      "title": "RestrictionType"
    },
    "ActiveConference": {
      "type": "object",
      "title": "ActiveConference",
      "properties": {
        "conferenceRecord": {
          "type": "string",
          "title": "Conference Record",
          "description": "Output only. Reference to the active ConferenceRecord resource. Format: conferenceRecords/{conference_record}"
        }
      }
    },
    "EntryPointAccess": {
      "enum": [
        "ENTRY_POINT_ACCESS_UNSPECIFIED",
        "ALL",
        "CREATOR_APP_ONLY"
      ],
      "type": "string",
      "title": "EntryPointAccess"
    },
    "SmartNotesConfig": {
      "type": "object",
      "title": "SmartNotesConfig",
      "properties": {
        "autoSmartNotesGeneration": {
          "enum": [
            "AUTO_GENERATION_TYPE_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Auto Smart Notes Generation",
          "description": "Controls automatic smart notes generation. Determines if AI-generated meeting summaries are created."
        }
      }
    },
    "AutoGenerationType": {
      "enum": [
        "AUTO_GENERATION_TYPE_UNSPECIFIED",
        "OFF",
        "ON"
      ],
      "type": "string",
      "title": "AutoGenerationType"
    },
    "CreateMeetResponse": {
      "type": "object",
      "title": "CreateMeetResponse",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Immutable. Resource name of the space. Format: spaces/{space} where {space} is a unique, server-generated, case-sensitive ID."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "properties": {
            "accessType": {
              "enum": [
                "ACCESS_TYPE_UNSPECIFIED",
                "OPEN",
                "TRUSTED",
                "RESTRICTED"
              ],
              "type": "string",
              "title": "Access Type",
              "description": "Access type determining who can join without knocking. Default: user's default access settings or RESTRICTED."
            },
            "moderation": {
              "enum": [
                "MODERATION_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Moderation",
              "description": "Pre-configured moderation mode for the meeting. Controls whether moderation features are enabled."
            },
            "artifactConfig": {
              "type": "object",
              "title": "Artifact Config",
              "properties": {
                "recordingConfig": {
                  "type": "object",
                  "title": "Recording Config",
                  "properties": {
                    "autoRecordingGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Recording Generation",
                      "description": "Controls automatic recording generation. Determines if meetings are automatically recorded."
                    }
                  },
                  "description": "Configuration for automatic recording of meetings."
                },
                "smartNotesConfig": {
                  "type": "object",
                  "title": "Smart Notes Config",
                  "properties": {
                    "autoSmartNotesGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Smart Notes Generation",
                      "description": "Controls automatic smart notes generation. Determines if AI-generated meeting summaries are created."
                    }
                  },
                  "description": "Configuration for automatic smart notes generation."
                },
                "transcriptionConfig": {
                  "type": "object",
                  "title": "Transcription Config",
                  "properties": {
                    "autoTranscriptionGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Transcription Generation",
                      "description": "Controls automatic transcription generation. Determines if meeting audio is automatically transcribed."
                    }
                  },
                  "description": "Configuration for automatic transcription of meetings."
                }
              },
              "description": "Configuration for meeting artifacts like recordings, transcriptions, and smart notes."
            },
            "entryPointAccess": {
              "enum": [
                "ENTRY_POINT_ACCESS_UNSPECIFIED",
                "ALL",
                "CREATOR_APP_ONLY"
              ],
              "type": "string",
              "title": "Entry Point Access",
              "description": "Defines which entry points can be used to join meetings in this space. Default: ALL."
            },
            "moderationRestrictions": {
              "type": "object",
              "title": "Moderation Restrictions",
              "properties": {
                "chatRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Chat Restriction",
                  "description": "Restriction level for chat functionality during moderated meetings."
                },
                "presentRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Present Restriction",
                  "description": "Restriction level for screen sharing/presenting during moderated meetings."
                },
                "reactionRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Reaction Restriction",
                  "description": "Restriction level for reactions during moderated meetings."
                },
                "defaultJoinAsViewerType": {
                  "enum": [
                    "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Default Join As Viewer Type",
                  "description": "Determines if participants join as viewers by default during moderated meetings."
                }
              },
              "description": "Restrictions applied to meeting features when moderation is enabled."
            },
            "attendanceReportGenerationType": {
              "enum": [
                "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
                "GENERATE_REPORT",
                "DO_NOT_GENERATE"
              ],
              "type": "string",
              "title": "Attendance Report Generation Type",
              "description": "Controls whether attendance reports are automatically generated for meetings in this space."
            }
          },
          "description": "Configuration pertaining to the meeting space."
        },
        "meetingUri": {
          "type": "string",
          "title": "Meeting Uri",
          "description": "Output only. URI used to join meetings, consisting of https://meet.google.com/ followed by the meeting code."
        },
        "meetingCode": {
          "type": "string",
          "title": "Meeting Code",
          "description": "Output only. Type-friendly unique string used to join the meeting. Format: [a-z]+-[a-z]+-[a-z]+. Maximum length: 128 characters."
        },
        "activeConference": {
          "type": "object",
          "title": "Active Conference",
          "properties": {
            "conferenceRecord": {
              "type": "string",
              "title": "Conference Record",
              "description": "Output only. Reference to the active ConferenceRecord resource. Format: conferenceRecords/{conference_record}"
            }
          },
          "description": "Active conference in this space, if any. Populated when a conference is ongoing."
        }
      }
    },
    "TranscriptionConfig": {
      "type": "object",
      "title": "TranscriptionConfig",
      "properties": {
        "autoTranscriptionGeneration": {
          "enum": [
            "AUTO_GENERATION_TYPE_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Auto Transcription Generation",
          "description": "Controls automatic transcription generation. Determines if meeting audio is automatically transcribed."
        }
      }
    },
    "ModerationRestrictions": {
      "type": "object",
      "title": "ModerationRestrictions",
      "properties": {
        "chatRestriction": {
          "enum": [
            "RESTRICTION_TYPE_UNSPECIFIED",
            "NO_RESTRICTION",
            "HOSTS_ONLY"
          ],
          "type": "string",
          "title": "Chat Restriction",
          "description": "Restriction level for chat functionality during moderated meetings."
        },
        "presentRestriction": {
          "enum": [
            "RESTRICTION_TYPE_UNSPECIFIED",
            "NO_RESTRICTION",
            "HOSTS_ONLY"
          ],
          "type": "string",
          "title": "Present Restriction",
          "description": "Restriction level for screen sharing/presenting during moderated meetings."
        },
        "reactionRestriction": {
          "enum": [
            "RESTRICTION_TYPE_UNSPECIFIED",
            "NO_RESTRICTION",
            "HOSTS_ONLY"
          ],
          "type": "string",
          "title": "Reaction Restriction",
          "description": "Restriction level for reactions during moderated meetings."
        },
        "defaultJoinAsViewerType": {
          "enum": [
            "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Default Join As Viewer Type",
          "description": "Determines if participants join as viewers by default during moderated meetings."
        }
      }
    },
    "DefaultJoinAsViewerType": {
      "enum": [
        "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
        "OFF",
        "ON"
      ],
      "type": "string",
      "title": "DefaultJoinAsViewerType"
    },
    "AttendanceReportGenerationType": {
      "enum": [
        "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
        "GENERATE_REPORT",
        "DO_NOT_GENERATE"
      ],
      "type": "string",
      "title": "AttendanceReportGenerationType"
    }
  },
  "title": "CreateMeetResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Immutable. Resource name of the space. Format: spaces/{space} where {space} is a unique, server-generated, case-sensitive ID."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "properties": {
            "accessType": {
              "enum": [
                "ACCESS_TYPE_UNSPECIFIED",
                "OPEN",
                "TRUSTED",
                "RESTRICTED"
              ],
              "type": "string",
              "title": "Access Type",
              "description": "Access type determining who can join without knocking. Default: user's default access settings or RESTRICTED."
            },
            "moderation": {
              "enum": [
                "MODERATION_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Moderation",
              "description": "Pre-configured moderation mode for the meeting. Controls whether moderation features are enabled."
            },
            "artifactConfig": {
              "type": "object",
              "title": "Artifact Config",
              "properties": {
                "recordingConfig": {
                  "type": "object",
                  "title": "Recording Config",
                  "properties": {
                    "autoRecordingGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Recording Generation",
                      "description": "Controls automatic recording generation. Determines if meetings are automatically recorded."
                    }
                  },
                  "description": "Configuration for automatic recording of meetings."
                },
                "smartNotesConfig": {
                  "type": "object",
                  "title": "Smart Notes Config",
                  "properties": {
                    "autoSmartNotesGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Smart Notes Generation",
                      "description": "Controls automatic smart notes generation. Determines if AI-generated meeting summaries are created."
                    }
                  },
                  "description": "Configuration for automatic smart notes generation."
                },
                "transcriptionConfig": {
                  "type": "object",
                  "title": "Transcription Config",
                  "properties": {
                    "autoTranscriptionGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Transcription Generation",
                      "description": "Controls automatic transcription generation. Determines if meeting audio is automatically transcribed."
                    }
                  },
                  "description": "Configuration for automatic transcription of meetings."
                }
              },
              "description": "Configuration for meeting artifacts like recordings, transcriptions, and smart notes."
            },
            "entryPointAccess": {
              "enum": [
                "ENTRY_POINT_ACCESS_UNSPECIFIED",
                "ALL",
                "CREATOR_APP_ONLY"
              ],
              "type": "string",
              "title": "Entry Point Access",
              "description": "Defines which entry points can be used to join meetings in this space. Default: ALL."
            },
            "moderationRestrictions": {
              "type": "object",
              "title": "Moderation Restrictions",
              "properties": {
                "chatRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Chat Restriction",
                  "description": "Restriction level for chat functionality during moderated meetings."
                },
                "presentRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Present Restriction",
                  "description": "Restriction level for screen sharing/presenting during moderated meetings."
                },
                "reactionRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Reaction Restriction",
                  "description": "Restriction level for reactions during moderated meetings."
                },
                "defaultJoinAsViewerType": {
                  "enum": [
                    "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Default Join As Viewer Type",
                  "description": "Determines if participants join as viewers by default during moderated meetings."
                }
              },
              "description": "Restrictions applied to meeting features when moderation is enabled."
            },
            "attendanceReportGenerationType": {
              "enum": [
                "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
                "GENERATE_REPORT",
                "DO_NOT_GENERATE"
              ],
              "type": "string",
              "title": "Attendance Report Generation Type",
              "description": "Controls whether attendance reports are automatically generated for meetings in this space."
            }
          },
          "description": "Configuration pertaining to the meeting space."
        },
        "meetingUri": {
          "type": "string",
          "title": "Meeting Uri",
          "description": "Output only. URI used to join meetings, consisting of https://meet.google.com/ followed by the meeting code."
        },
        "meetingCode": {
          "type": "string",
          "title": "Meeting Code",
          "description": "Output only. Type-friendly unique string used to join the meeting. Format: [a-z]+-[a-z]+-[a-z]+. Maximum length: 128 characters."
        },
        "activeConference": {
          "type": "object",
          "title": "Active Conference",
          "properties": {
            "conferenceRecord": {
              "type": "string",
              "title": "Conference Record",
              "description": "Output only. Reference to the active ConferenceRecord resource. Format: conferenceRecords/{conference_record}"
            }
          },
          "description": "Active conference in this space, if any. Populated when a conference is ongoing."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_END_ACTIVE_CONFERENCE
Ends an active conference in a Google Meet space. REQUIRES 'space_name' parameter (e.g., 'spaces/jQCFfuBOdN5z' or just 'jQCFfuBOdN5z'). Use when you need to terminate an ongoing conference in a specified space. This operation only succeeds if a conference is actively running in the space. You must always provide the space_name to identify which space's conference to end. Immediately drops all active participants — obtain explicit user confirmation before calling.

**Input schema:**
```json
{
  "type": "object",
  "title": "EndActiveConferenceRequest",
  "required": [
    "space_name"
  ],
  "properties": {
    "space_name": {
      "type": "string",
      "title": "Space Name",
      "examples": [
        "spaces/jQCFfuBOdN5z",
        "jQCFfuBOdN5z"
      ],
      "description": "REQUIRED. Resource name of the space in the format 'spaces/{space}' where {space} is a unique, case-sensitive server-generated ID. Example: 'spaces/jQCFfuBOdN5z'. This can be the full resource name including the 'spaces/' prefix or just the space ID. You must always provide this parameter."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "EndActiveConferenceResponse": {
      "type": "object",
      "title": "EndActiveConferenceResponse",
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "default": "Active conference ended successfully",
          "description": "Status message indicating the result of the operation."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "default": true,
          "description": "Indicates whether the active conference was successfully ended."
        }
      }
    }
  },
  "title": "EndActiveConferenceResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "message": {
          "type": "string",
          "title": "Message",
          "default": "Active conference ended successfully",
          "description": "Status message indicating the result of the operation."
        },
        "success": {
          "type": "boolean",
          "title": "Success",
          "default": true,
          "description": "Indicates whether the active conference was successfully ended."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_GET_CONFERENCE_RECORD_BY_NAME
Tool to get a specific conference record by its resource name. Use when you have the conference record ID and need to retrieve detailed information about a single meeting instance.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetConferenceRecordByNameRequest",
  "required": [
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "conferenceRecords/GLkPdCDLsjSXet2-QH9dDxIPOAIIigIgABgECA"
      ],
      "description": "Required. Resource name of the conference record. Format: 'conferenceRecords/{conference_record}' where {conference_record} is a unique ID for each instance of a call within a space. Example: 'conferenceRecords/GLkPdCDLsjSXet2-QH9dDxIPOAIIigIgABgECA'"
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetConferenceRecordByNameResponse": {
      "type": "object",
      "title": "GetConferenceRecordByNameResponse",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the conference record. Format: conferenceRecords/{conference_record} where {conference_record} is a unique ID for each instance of a call within a space."
        },
        "space": {
          "type": "string",
          "title": "Space",
          "description": "The space where the conference was held. Resource name format: spaces/{space}"
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp when the conference ended. Set for past conferences. Unset if the conference is ongoing. A timestamp in RFC3339 UTC 'Zulu' format, with nanosecond resolution and up to nine fractional digits."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp when the conference started. A timestamp in RFC3339 UTC 'Zulu' format, with nanosecond resolution and up to nine fractional digits."
        },
        "expireTime": {
          "type": "string",
          "title": "Expire Time",
          "description": "Server enforced expiration time for when this conference record resource is deleted. The resource is automatically deleted 30 days after the conference ends. A timestamp in RFC3339 UTC 'Zulu' format."
        }
      }
    }
  },
  "title": "GetConferenceRecordByNameResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the conference record. Format: conferenceRecords/{conference_record} where {conference_record} is a unique ID for each instance of a call within a space."
        },
        "space": {
          "type": "string",
          "title": "Space",
          "description": "The space where the conference was held. Resource name format: spaces/{space}"
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp when the conference ended. Set for past conferences. Unset if the conference is ongoing. A timestamp in RFC3339 UTC 'Zulu' format, with nanosecond resolution and up to nine fractional digits."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp when the conference started. A timestamp in RFC3339 UTC 'Zulu' format, with nanosecond resolution and up to nine fractional digits."
        },
        "expireTime": {
          "type": "string",
          "title": "Expire Time",
          "description": "Server enforced expiration time for when this conference record resource is deleted. The resource is automatically deleted 30 days after the conference ends. A timestamp in RFC3339 UTC 'Zulu' format."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_GET_MEET
Retrieve details of a Google Meet space using its unique identifier. Newly created spaces may return incomplete data; retry after 1–3 seconds if needed.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetMeetRequest",
  "required": [
    "space_name"
  ],
  "properties": {
    "space_name": {
      "type": "string",
      "title": "Space Name",
      "examples": [
        "mV63iV9-KxoB"
      ],
      "description": "The unique identifier (space ID) for the Google Meet space. Provide only the raw space ID without the 'spaces/' prefix. Example: 'mV63iV9-KxoB'."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Config": {
      "type": "object",
      "title": "Config",
      "properties": {
        "accessType": {
          "type": "string",
          "title": "Access Type",
          "description": "Controls who can join a meeting space without knocking. Possible values: ACCESS_TYPE_UNSPECIFIED (default per organization), OPEN (anyone with join info), TRUSTED (organization members and invited users), RESTRICTED (invitees only)."
        },
        "moderation": {
          "type": "string",
          "title": "Moderation",
          "description": "Determines the moderation setting for a meeting. Possible values: MODERATION_UNSPECIFIED, OFF (moderation disabled), ON (moderation enabled)."
        },
        "artifactConfig": {
          "type": "object",
          "title": "Artifact Config",
          "properties": {
            "recordingConfig": {
              "type": "object",
              "title": "Recording Config",
              "properties": {
                "autoRecordingGeneration": {
                  "type": "string",
                  "title": "Auto Recording Generation",
                  "description": "Defines whether a meeting space is automatically recorded when someone with the privilege to record joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED (default per user policy), ON (automatically generated), OFF (not automatically generated)."
                }
              },
              "description": "Configuration for automatic recording generation."
            },
            "smartNotesConfig": {
              "type": "object",
              "title": "Smart Notes Config",
              "properties": {
                "autoSmartNotesGeneration": {
                  "type": "string",
                  "title": "Auto Smart Notes Generation",
                  "description": "Defines whether to automatically generate a summary and recap of the meeting for all invitees in the organization when someone with the privilege to enable smart notes joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
                }
              },
              "description": "Configuration for automatic smart notes generation."
            },
            "transcriptionConfig": {
              "type": "object",
              "title": "Transcription Config",
              "properties": {
                "autoTranscriptionGeneration": {
                  "type": "string",
                  "title": "Auto Transcription Generation",
                  "description": "Defines whether the content of a meeting is automatically transcribed when someone with the privilege to transcribe joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
                }
              },
              "description": "Configuration for automatic transcription generation."
            }
          },
          "description": "Settings for recordings, transcriptions, and smart notes generation."
        },
        "entryPointAccess": {
          "type": "string",
          "title": "Entry Point Access",
          "description": "Specifies which platforms can be used to access meetings. Possible values: ENTRY_POINT_ACCESS_UNSPECIFIED, ALL (all entry points allowed), CREATOR_APP_ONLY (only entry points owned by the creating Google Cloud project)."
        },
        "moderationRestrictions": {
          "type": "object",
          "title": "Moderation Restrictions",
          "properties": {
            "chatRestriction": {
              "type": "string",
              "title": "Chat Restriction",
              "description": "Restriction level for chat feature. Possible values: RESTRICTION_TYPE_UNSPECIFIED (default per user policy), HOSTS_ONLY (meeting owner and co-host only), NO_RESTRICTION (all participants)."
            },
            "presentRestriction": {
              "type": "string",
              "title": "Present Restriction",
              "description": "Restriction level for screen sharing/presentation. Possible values: RESTRICTION_TYPE_UNSPECIFIED, HOSTS_ONLY, NO_RESTRICTION."
            },
            "reactionRestriction": {
              "type": "string",
              "title": "Reaction Restriction",
              "description": "Restriction level for reactions feature. Possible values: RESTRICTION_TYPE_UNSPECIFIED, HOSTS_ONLY, NO_RESTRICTION."
            },
            "defaultJoinAsViewerType": {
              "type": "string",
              "title": "Default Join As Viewer Type",
              "description": "Controls whether users join as viewers by default. Possible values: DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED (default per user policy), ON (join as viewers), OFF (join as contributors)."
            }
          },
          "description": "Feature restrictions applied when moderation is enabled. Resets to defaults when moderation is disabled."
        },
        "attendanceReportGenerationType": {
          "type": "string",
          "title": "Attendance Report Generation Type",
          "description": "Determines if attendance reports are auto-generated and distributed. Possible values: ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED (default per user policy), GENERATE_REPORT (report generated and sent to drive/email), DO_NOT_GENERATE (no report generated)."
        }
      },
      "description": "Configuration pertaining to the meeting space, including access controls, moderation settings, and artifact generation configurations."
    },
    "ArtifactConfig": {
      "type": "object",
      "title": "ArtifactConfig",
      "properties": {
        "recordingConfig": {
          "type": "object",
          "title": "Recording Config",
          "properties": {
            "autoRecordingGeneration": {
              "type": "string",
              "title": "Auto Recording Generation",
              "description": "Defines whether a meeting space is automatically recorded when someone with the privilege to record joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED (default per user policy), ON (automatically generated), OFF (not automatically generated)."
            }
          },
          "description": "Configuration for automatic recording generation."
        },
        "smartNotesConfig": {
          "type": "object",
          "title": "Smart Notes Config",
          "properties": {
            "autoSmartNotesGeneration": {
              "type": "string",
              "title": "Auto Smart Notes Generation",
              "description": "Defines whether to automatically generate a summary and recap of the meeting for all invitees in the organization when someone with the privilege to enable smart notes joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
            }
          },
          "description": "Configuration for automatic smart notes generation."
        },
        "transcriptionConfig": {
          "type": "object",
          "title": "Transcription Config",
          "properties": {
            "autoTranscriptionGeneration": {
              "type": "string",
              "title": "Auto Transcription Generation",
              "description": "Defines whether the content of a meeting is automatically transcribed when someone with the privilege to transcribe joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
            }
          },
          "description": "Configuration for automatic transcription generation."
        }
      },
      "description": "Settings for recordings, transcriptions, and smart notes generation."
    },
    "GetMeetResponse": {
      "type": "object",
      "title": "GetMeetResponse",
      "required": [
        "name"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource identifier formatted as spaces/{space}. The {space} value is a unique, case-sensitive server-generated ID (e.g., jQCFfuBOdN5z). Immutable."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "properties": {
            "accessType": {
              "type": "string",
              "title": "Access Type",
              "description": "Controls who can join a meeting space without knocking. Possible values: ACCESS_TYPE_UNSPECIFIED (default per organization), OPEN (anyone with join info), TRUSTED (organization members and invited users), RESTRICTED (invitees only)."
            },
            "moderation": {
              "type": "string",
              "title": "Moderation",
              "description": "Determines the moderation setting for a meeting. Possible values: MODERATION_UNSPECIFIED, OFF (moderation disabled), ON (moderation enabled)."
            },
            "artifactConfig": {
              "type": "object",
              "title": "Artifact Config",
              "properties": {
                "recordingConfig": {
                  "type": "object",
                  "title": "Recording Config",
                  "properties": {
                    "autoRecordingGeneration": {
                      "type": "string",
                      "title": "Auto Recording Generation",
                      "description": "Defines whether a meeting space is automatically recorded when someone with the privilege to record joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED (default per user policy), ON (automatically generated), OFF (not automatically generated)."
                    }
                  },
                  "description": "Configuration for automatic recording generation."
                },
                "smartNotesConfig": {
                  "type": "object",
                  "title": "Smart Notes Config",
                  "properties": {
                    "autoSmartNotesGeneration": {
                      "type": "string",
                      "title": "Auto Smart Notes Generation",
                      "description": "Defines whether to automatically generate a summary and recap of the meeting for all invitees in the organization when someone with the privilege to enable smart notes joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
                    }
                  },
                  "description": "Configuration for automatic smart notes generation."
                },
                "transcriptionConfig": {
                  "type": "object",
                  "title": "Transcription Config",
                  "properties": {
                    "autoTranscriptionGeneration": {
                      "type": "string",
                      "title": "Auto Transcription Generation",
                      "description": "Defines whether the content of a meeting is automatically transcribed when someone with the privilege to transcribe joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
                    }
                  },
                  "description": "Configuration for automatic transcription generation."
                }
              },
              "description": "Settings for recordings, transcriptions, and smart notes generation."
            },
            "entryPointAccess": {
              "type": "string",
              "title": "Entry Point Access",
              "description": "Specifies which platforms can be used to access meetings. Possible values: ENTRY_POINT_ACCESS_UNSPECIFIED, ALL (all entry points allowed), CREATOR_APP_ONLY (only entry points owned by the creating Google Cloud project)."
            },
            "moderationRestrictions": {
              "type": "object",
              "title": "Moderation Restrictions",
              "properties": {
                "chatRestriction": {
                  "type": "string",
                  "title": "Chat Restriction",
                  "description": "Restriction level for chat feature. Possible values: RESTRICTION_TYPE_UNSPECIFIED (default per user policy), HOSTS_ONLY (meeting owner and co-host only), NO_RESTRICTION (all participants)."
                },
                "presentRestriction": {
                  "type": "string",
                  "title": "Present Restriction",
                  "description": "Restriction level for screen sharing/presentation. Possible values: RESTRICTION_TYPE_UNSPECIFIED, HOSTS_ONLY, NO_RESTRICTION."
                },
                "reactionRestriction": {
                  "type": "string",
                  "title": "Reaction Restriction",
                  "description": "Restriction level for reactions feature. Possible values: RESTRICTION_TYPE_UNSPECIFIED, HOSTS_ONLY, NO_RESTRICTION."
                },
                "defaultJoinAsViewerType": {
                  "type": "string",
                  "title": "Default Join As Viewer Type",
                  "description": "Controls whether users join as viewers by default. Possible values: DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED (default per user policy), ON (join as viewers), OFF (join as contributors)."
                }
              },
              "description": "Feature restrictions applied when moderation is enabled. Resets to defaults when moderation is disabled."
            },
            "attendanceReportGenerationType": {
              "type": "string",
              "title": "Attendance Report Generation Type",
              "description": "Determines if attendance reports are auto-generated and distributed. Possible values: ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED (default per user policy), GENERATE_REPORT (report generated and sent to drive/email), DO_NOT_GENERATE (no report generated)."
            }
          },
          "description": "Configuration pertaining to the meeting space, including access controls, moderation settings, and artifact generation configurations."
        },
        "meetingUri": {
          "type": "string",
          "title": "Meeting Uri",
          "description": "Output only. URI used to join meetings, constructed as https://meet.google.com/ followed by the meeting code (e.g., https://meet.google.com/abc-mnop-xyz)."
        },
        "meetingCode": {
          "type": "string",
          "title": "Meeting Code",
          "description": "Output only. Human-friendly unique identifier for joining meetings with format [a-z]+-[a-z]+-[a-z]+ (e.g., abc-mnop-xyz). Maximum length is 128 characters. Can serve as an alias for the space name when retrieving space details."
        },
        "activeConference": {
          "type": "object",
          "title": "Active Conference",
          "properties": {
            "conferenceRecord": {
              "type": "string",
              "title": "Conference Record",
              "description": "Output only. Reference to the ConferenceRecord resource, formatted as conferenceRecords/{conferenceRecord} where the ID uniquely identifies each meeting instance."
            }
          },
          "description": "Represents the currently active conference if one exists. Only one active conference can occur in a space at any given time."
        }
      },
      "description": "Response containing details of a Google Meet space."
    },
    "RecordingConfig": {
      "type": "object",
      "title": "RecordingConfig",
      "properties": {
        "autoRecordingGeneration": {
          "type": "string",
          "title": "Auto Recording Generation",
          "description": "Defines whether a meeting space is automatically recorded when someone with the privilege to record joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED (default per user policy), ON (automatically generated), OFF (not automatically generated)."
        }
      },
      "description": "Configuration for automatic recording generation."
    },
    "ActiveConference": {
      "type": "object",
      "title": "ActiveConference",
      "properties": {
        "conferenceRecord": {
          "type": "string",
          "title": "Conference Record",
          "description": "Output only. Reference to the ConferenceRecord resource, formatted as conferenceRecords/{conferenceRecord} where the ID uniquely identifies each meeting instance."
        }
      },
      "description": "Represents the currently active conference if one exists. Only one active conference can occur in a space at any given time."
    },
    "SmartNotesConfig": {
      "type": "object",
      "title": "SmartNotesConfig",
      "properties": {
        "autoSmartNotesGeneration": {
          "type": "string",
          "title": "Auto Smart Notes Generation",
          "description": "Defines whether to automatically generate a summary and recap of the meeting for all invitees in the organization when someone with the privilege to enable smart notes joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
        }
      },
      "description": "Configuration for automatic smart notes generation."
    },
    "TranscriptionConfig": {
      "type": "object",
      "title": "TranscriptionConfig",
      "properties": {
        "autoTranscriptionGeneration": {
          "type": "string",
          "title": "Auto Transcription Generation",
          "description": "Defines whether the content of a meeting is automatically transcribed when someone with the privilege to transcribe joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
        }
      },
      "description": "Configuration for automatic transcription generation."
    },
    "ModerationRestrictions": {
      "type": "object",
      "title": "ModerationRestrictions",
      "properties": {
        "chatRestriction": {
          "type": "string",
          "title": "Chat Restriction",
          "description": "Restriction level for chat feature. Possible values: RESTRICTION_TYPE_UNSPECIFIED (default per user policy), HOSTS_ONLY (meeting owner and co-host only), NO_RESTRICTION (all participants)."
        },
        "presentRestriction": {
          "type": "string",
          "title": "Present Restriction",
          "description": "Restriction level for screen sharing/presentation. Possible values: RESTRICTION_TYPE_UNSPECIFIED, HOSTS_ONLY, NO_RESTRICTION."
        },
        "reactionRestriction": {
          "type": "string",
          "title": "Reaction Restriction",
          "description": "Restriction level for reactions feature. Possible values: RESTRICTION_TYPE_UNSPECIFIED, HOSTS_ONLY, NO_RESTRICTION."
        },
        "defaultJoinAsViewerType": {
          "type": "string",
          "title": "Default Join As Viewer Type",
          "description": "Controls whether users join as viewers by default. Possible values: DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED (default per user policy), ON (join as viewers), OFF (join as contributors)."
        }
      },
      "description": "Feature restrictions applied when moderation is enabled. Resets to defaults when moderation is disabled."
    }
  },
  "title": "GetMeetResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "name"
      ],
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource identifier formatted as spaces/{space}. The {space} value is a unique, case-sensitive server-generated ID (e.g., jQCFfuBOdN5z). Immutable."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "properties": {
            "accessType": {
              "type": "string",
              "title": "Access Type",
              "description": "Controls who can join a meeting space without knocking. Possible values: ACCESS_TYPE_UNSPECIFIED (default per organization), OPEN (anyone with join info), TRUSTED (organization members and invited users), RESTRICTED (invitees only)."
            },
            "moderation": {
              "type": "string",
              "title": "Moderation",
              "description": "Determines the moderation setting for a meeting. Possible values: MODERATION_UNSPECIFIED, OFF (moderation disabled), ON (moderation enabled)."
            },
            "artifactConfig": {
              "type": "object",
              "title": "Artifact Config",
              "properties": {
                "recordingConfig": {
                  "type": "object",
                  "title": "Recording Config",
                  "properties": {
                    "autoRecordingGeneration": {
                      "type": "string",
                      "title": "Auto Recording Generation",
                      "description": "Defines whether a meeting space is automatically recorded when someone with the privilege to record joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED (default per user policy), ON (automatically generated), OFF (not automatically generated)."
                    }
                  },
                  "description": "Configuration for automatic recording generation."
                },
                "smartNotesConfig": {
                  "type": "object",
                  "title": "Smart Notes Config",
                  "properties": {
                    "autoSmartNotesGeneration": {
                      "type": "string",
                      "title": "Auto Smart Notes Generation",
                      "description": "Defines whether to automatically generate a summary and recap of the meeting for all invitees in the organization when someone with the privilege to enable smart notes joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
                    }
                  },
                  "description": "Configuration for automatic smart notes generation."
                },
                "transcriptionConfig": {
                  "type": "object",
                  "title": "Transcription Config",
                  "properties": {
                    "autoTranscriptionGeneration": {
                      "type": "string",
                      "title": "Auto Transcription Generation",
                      "description": "Defines whether the content of a meeting is automatically transcribed when someone with the privilege to transcribe joins. Possible values: AUTO_GENERATION_TYPE_UNSPECIFIED, ON, OFF."
                    }
                  },
                  "description": "Configuration for automatic transcription generation."
                }
              },
              "description": "Settings for recordings, transcriptions, and smart notes generation."
            },
            "entryPointAccess": {
              "type": "string",
              "title": "Entry Point Access",
              "description": "Specifies which platforms can be used to access meetings. Possible values: ENTRY_POINT_ACCESS_UNSPECIFIED, ALL (all entry points allowed), CREATOR_APP_ONLY (only entry points owned by the creating Google Cloud project)."
            },
            "moderationRestrictions": {
              "type": "object",
              "title": "Moderation Restrictions",
              "properties": {
                "chatRestriction": {
                  "type": "string",
                  "title": "Chat Restriction",
                  "description": "Restriction level for chat feature. Possible values: RESTRICTION_TYPE_UNSPECIFIED (default per user policy), HOSTS_ONLY (meeting owner and co-host only), NO_RESTRICTION (all participants)."
                },
                "presentRestriction": {
                  "type": "string",
                  "title": "Present Restriction",
                  "description": "Restriction level for screen sharing/presentation. Possible values: RESTRICTION_TYPE_UNSPECIFIED, HOSTS_ONLY, NO_RESTRICTION."
                },
                "reactionRestriction": {
                  "type": "string",
                  "title": "Reaction Restriction",
                  "description": "Restriction level for reactions feature. Possible values: RESTRICTION_TYPE_UNSPECIFIED, HOSTS_ONLY, NO_RESTRICTION."
                },
                "defaultJoinAsViewerType": {
                  "type": "string",
                  "title": "Default Join As Viewer Type",
                  "description": "Controls whether users join as viewers by default. Possible values: DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED (default per user policy), ON (join as viewers), OFF (join as contributors)."
                }
              },
              "description": "Feature restrictions applied when moderation is enabled. Resets to defaults when moderation is disabled."
            },
            "attendanceReportGenerationType": {
              "type": "string",
              "title": "Attendance Report Generation Type",
              "description": "Determines if attendance reports are auto-generated and distributed. Possible values: ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED (default per user policy), GENERATE_REPORT (report generated and sent to drive/email), DO_NOT_GENERATE (no report generated)."
            }
          },
          "description": "Configuration pertaining to the meeting space, including access controls, moderation settings, and artifact generation configurations."
        },
        "meetingUri": {
          "type": "string",
          "title": "Meeting Uri",
          "description": "Output only. URI used to join meetings, constructed as https://meet.google.com/ followed by the meeting code (e.g., https://meet.google.com/abc-mnop-xyz)."
        },
        "meetingCode": {
          "type": "string",
          "title": "Meeting Code",
          "description": "Output only. Human-friendly unique identifier for joining meetings with format [a-z]+-[a-z]+-[a-z]+ (e.g., abc-mnop-xyz). Maximum length is 128 characters. Can serve as an alias for the space name when retrieving space details."
        },
        "activeConference": {
          "type": "object",
          "title": "Active Conference",
          "properties": {
            "conferenceRecord": {
              "type": "string",
              "title": "Conference Record",
              "description": "Output only. Reference to the ConferenceRecord resource, formatted as conferenceRecords/{conferenceRecord} where the ID uniquely identifies each meeting instance."
            }
          },
          "description": "Represents the currently active conference if one exists. Only one active conference can occur in a space at any given time."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_GET_PARTICIPANT_SESSION
Retrieves detailed information about a specific participant session from a Google Meet conference record. Returns session details including start time and end time for a single join/leave session. A participant session represents each unique join or leave session when a user joins a conference from a device. If a user joins multiple times from the same device, each join creates a new session. PREREQUISITE: You must first obtain the participant session resource name. Use LIST_PARTICIPANT_SESSIONS with a conference record ID and participant ID to get available sessions and their resource names. The 'name' parameter is REQUIRED and must be in the format: 'conferenceRecords/{conference_record}/participants/{participant}/participantSessions/{participant_session}'

**Input schema:**
```json
{
  "type": "object",
  "title": "GetParticipantSessionRequest",
  "required": [
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "conferenceRecords/abc-123-def/participants/xyz-456/participantSessions/pqr-789"
      ],
      "description": "Required. Full resource name of the participant session to retrieve. Format: 'conferenceRecords/{conference_record}/participants/{participant}/participantSessions/{participant_session}'. You can obtain this value from the 'name' field returned by the LIST_PARTICIPANT_SESSIONS action."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetParticipantSessionResponse": {
      "type": "object",
      "title": "GetParticipantSessionResponse",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Identifier. Session id in the format `conferenceRecords/{conferenceRecord}/participants/{participant}/participantSessions/{participantSession}`."
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Output only. Timestamp when the user session ends. Unset if the user session hasn't ended."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Output only. Timestamp when the user session starts."
        }
      }
    }
  },
  "title": "GetParticipantSessionResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Identifier. Session id in the format `conferenceRecords/{conferenceRecord}/participants/{participant}/participantSessions/{participantSession}`."
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Output only. Timestamp when the user session ends. Unset if the user session hasn't ended."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Output only. Timestamp when the user session starts."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_GET_RECORDINGS_BY_CONFERENCE_RECORD_ID
Retrieves recordings from Google Meet for a given conference record ID. Only returns recordings if recording was enabled and permitted by the organizer's domain policies; a valid conferenceRecord_id does not guarantee recordings exist. After a meeting ends, recordings may take several minutes to process — an empty result may be temporary, not permanent.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetRecordingsByConferenceRecordIdRequest",
  "required": [
    "conferenceRecord_id"
  ],
  "properties": {
    "conferenceRecord_id": {
      "type": "string",
      "title": "Conference Record Id",
      "description": "Unique identifier for the conference record."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Recording": {
      "type": "object",
      "title": "Recording",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the recording. Format: conferenceRecords/{conferenceRecord}/recordings/{recording}. Output only."
        },
        "state": {
          "enum": [
            "STATE_UNSPECIFIED",
            "STARTED",
            "ENDED",
            "FILE_GENERATED"
          ],
          "type": "string",
          "title": "State",
          "description": "Current state of the recording. Possible values: STATE_UNSPECIFIED (default), STARTED (active recording session), ENDED (recording ended, file pending), FILE_GENERATED (recording file ready). Output only."
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp when the recording ended. Output only."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp when the recording started. Output only."
        },
        "driveDestination": {
          "type": "object",
          "title": "Drive Destination",
          "properties": {
            "file": {
              "type": "string",
              "title": "File",
              "description": "The fileId for the underlying MP4 file. For use with the Drive API."
            },
            "exportUri": {
              "type": "string",
              "title": "Export Uri",
              "description": "Link used to play back the recording file in the browser."
            }
          },
          "description": "Recording is saved to Google Drive as an MP4 file. Output only."
        }
      },
      "description": "Represents a single recording from a conference."
    },
    "DriveDestination": {
      "type": "object",
      "title": "DriveDestination",
      "properties": {
        "file": {
          "type": "string",
          "title": "File",
          "description": "The fileId for the underlying MP4 file. For use with the Drive API."
        },
        "exportUri": {
          "type": "string",
          "title": "Export Uri",
          "description": "Link used to play back the recording file in the browser."
        }
      },
      "description": "Recording is saved to Google Drive as an MP4 file."
    },
    "GetRecordingsByConferenceRecordIdResponse": {
      "type": "object",
      "title": "GetRecordingsByConferenceRecordIdResponse",
      "properties": {
        "recordings": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Recording",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the recording. Format: conferenceRecords/{conferenceRecord}/recordings/{recording}. Output only."
              },
              "state": {
                "enum": [
                  "STATE_UNSPECIFIED",
                  "STARTED",
                  "ENDED",
                  "FILE_GENERATED"
                ],
                "type": "string",
                "title": "State",
                "description": "Current state of the recording. Possible values: STATE_UNSPECIFIED (default), STARTED (active recording session), ENDED (recording ended, file pending), FILE_GENERATED (recording file ready). Output only."
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp when the recording ended. Output only."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp when the recording started. Output only."
              },
              "driveDestination": {
                "type": "object",
                "title": "Drive Destination",
                "properties": {
                  "file": {
                    "type": "string",
                    "title": "File",
                    "description": "The fileId for the underlying MP4 file. For use with the Drive API."
                  },
                  "exportUri": {
                    "type": "string",
                    "title": "Export Uri",
                    "description": "Link used to play back the recording file in the browser."
                  }
                },
                "description": "Recording is saved to Google Drive as an MP4 file. Output only."
              }
            },
            "description": "Represents a single recording from a conference."
          },
          "title": "Recordings",
          "description": "List of recordings in one page."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List does not include all the recordings. Unset if all recordings are returned."
        }
      },
      "description": "Response containing a list of recordings and optional pagination token."
    }
  },
  "title": "GetRecordingsByConferenceRecordIdResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "recordings": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Recording",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the recording. Format: conferenceRecords/{conferenceRecord}/recordings/{recording}. Output only."
              },
              "state": {
                "enum": [
                  "STATE_UNSPECIFIED",
                  "STARTED",
                  "ENDED",
                  "FILE_GENERATED"
                ],
                "type": "string",
                "title": "State",
                "description": "Current state of the recording. Possible values: STATE_UNSPECIFIED (default), STARTED (active recording session), ENDED (recording ended, file pending), FILE_GENERATED (recording file ready). Output only."
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp when the recording ended. Output only."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp when the recording started. Output only."
              },
              "driveDestination": {
                "type": "object",
                "title": "Drive Destination",
                "properties": {
                  "file": {
                    "type": "string",
                    "title": "File",
                    "description": "The fileId for the underlying MP4 file. For use with the Drive API."
                  },
                  "exportUri": {
                    "type": "string",
                    "title": "Export Uri",
                    "description": "Link used to play back the recording file in the browser."
                  }
                },
                "description": "Recording is saved to Google Drive as an MP4 file. Output only."
              }
            },
            "description": "Represents a single recording from a conference."
          },
          "title": "Recordings",
          "description": "List of recordings in one page."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List does not include all the recordings. Unset if all recordings are returned."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_GET_TRANSCRIPT
Retrieves a specific transcript by its resource name. Returns transcript details including state (STARTED, ENDED, FILE_GENERATED), start/end times, and Google Docs destination. PREREQUISITE: Obtain the transcript resource name first by using GET_TRANSCRIPTS_BY_CONFERENCE_RECORD_ID or construct it from known IDs.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetTranscriptRequest",
  "required": [
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "conferenceRecords/GLkPdCDLsjSXet2-QH9dDxIPOAIIigIgABgECA/transcripts/0964dbd3-dc84-4515-a227-21e04ae2a4ab"
      ],
      "description": "Required. Resource name of the transcript. Format: 'conferenceRecords/{conferenceRecord}/transcripts/{transcript}'. You can obtain this from the 'Get Transcripts by Conference Record ID' action or construct it using known conference record and transcript IDs."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "DocsDestination": {
      "type": "object",
      "title": "DocsDestination",
      "properties": {
        "document": {
          "type": "string",
          "title": "Document",
          "description": "Document ID for the underlying Google Docs transcript file"
        },
        "exportUri": {
          "type": "string",
          "title": "Export Uri",
          "description": "URI for accessing the Google Docs transcript file"
        }
      },
      "description": "Location where the Google Docs transcript is saved."
    },
    "GetTranscriptResponse": {
      "type": "object",
      "title": "GetTranscriptResponse",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the transcript. Format: conferenceRecords/{conferenceRecord}/transcripts/{transcript}"
        },
        "state": {
          "type": "string",
          "title": "State",
          "description": "Current state of the transcript. Possible values: STATE_UNSPECIFIED (default, unused), STARTED (active transcript session in progress), ENDED (session completed; file generation pending), FILE_GENERATED (transcript file ready for download)"
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp when the transcript stopped recording. RFC3339 UTC format with nanosecond resolution."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp when the transcript began recording. RFC3339 UTC format with nanosecond resolution."
        },
        "docsDestination": {
          "type": "object",
          "title": "Docs Destination",
          "properties": {
            "document": {
              "type": "string",
              "title": "Document",
              "description": "Document ID for the underlying Google Docs transcript file"
            },
            "exportUri": {
              "type": "string",
              "title": "Export Uri",
              "description": "URI for accessing the Google Docs transcript file"
            }
          },
          "description": "Location where the Google Docs transcript is saved"
        }
      }
    }
  },
  "title": "GetTranscriptResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the transcript. Format: conferenceRecords/{conferenceRecord}/transcripts/{transcript}"
        },
        "state": {
          "type": "string",
          "title": "State",
          "description": "Current state of the transcript. Possible values: STATE_UNSPECIFIED (default, unused), STARTED (active transcript session in progress), ENDED (session completed; file generation pending), FILE_GENERATED (transcript file ready for download)"
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp when the transcript stopped recording. RFC3339 UTC format with nanosecond resolution."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp when the transcript began recording. RFC3339 UTC format with nanosecond resolution."
        },
        "docsDestination": {
          "type": "object",
          "title": "Docs Destination",
          "properties": {
            "document": {
              "type": "string",
              "title": "Document",
              "description": "Document ID for the underlying Google Docs transcript file"
            },
            "exportUri": {
              "type": "string",
              "title": "Export Uri",
              "description": "URI for accessing the Google Docs transcript file"
            }
          },
          "description": "Location where the Google Docs transcript is saved"
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_GET_TRANSCRIPT_ENTRY
Fetches a single transcript entry by resource name for targeted inspection or incremental processing. Use when you have a specific transcript entry resource name and need to retrieve its details (text, speaker, timestamps, language). PREREQUISITE: Obtain the transcript entry resource name first by using LIST_TRANSCRIPT_ENTRIES or construct it from known IDs. The 'name' parameter is REQUIRED and must follow the format: 'conferenceRecords/{conferenceRecordId}/transcripts/{transcriptId}/entries/{entryId}'

**Input schema:**
```json
{
  "type": "object",
  "title": "GetTranscriptEntryRequest",
  "required": [
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "conferenceRecords/abc-123-def/transcripts/xyz-456/entries/entry-789"
      ],
      "description": "Required. Full resource name of the transcript entry. Format: 'conferenceRecords/{conferenceRecordId}/transcripts/{transcriptId}/entries/{entryId}'. You can obtain this from the LIST_TRANSCRIPT_ENTRIES action or construct it using known conference record, transcript, and entry IDs."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetTranscriptEntryResponse": {
      "type": "object",
      "title": "GetTranscriptEntryResponse",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the entry. Format: conferenceRecords/{conferenceRecord}/transcripts/{transcript}/entries/{entry}"
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The transcribed text of the participant's voice, at maximum 10K words."
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "format": "date-time",
          "description": "Timestamp when the transcript entry ended."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "format": "date-time",
          "description": "Timestamp when the transcript entry started."
        },
        "participant": {
          "type": "string",
          "title": "Participant",
          "description": "Identifies the participant who speaks."
        },
        "languageCode": {
          "type": "string",
          "title": "Language Code",
          "description": "Language of spoken text, such as 'en-US'. IETF BCP 47 syntax."
        }
      }
    }
  },
  "title": "GetTranscriptEntryResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the entry. Format: conferenceRecords/{conferenceRecord}/transcripts/{transcript}/entries/{entry}"
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The transcribed text of the participant's voice, at maximum 10K words."
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "format": "date-time",
          "description": "Timestamp when the transcript entry ended."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "format": "date-time",
          "description": "Timestamp when the transcript entry started."
        },
        "participant": {
          "type": "string",
          "title": "Participant",
          "description": "Identifies the participant who speaks."
        },
        "languageCode": {
          "type": "string",
          "title": "Language Code",
          "description": "Language of spoken text, such as 'en-US'. IETF BCP 47 syntax."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_GET_TRANSCRIPTS_BY_CONFERENCE_RECORD_ID
Retrieves all transcripts for a specific Google Meet conference using its conferenceRecord_id. Transcripts require processing time after a meeting ends — empty results may be transient; retry after a delay before concluding no transcripts exist. Returns results only if transcription was enabled during the meeting and permitted by the organizer's domain policies; an empty list may also indicate transcription was never generated.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetTranscriptsByConferenceRecordIdRequest",
  "required": [
    "conferenceRecord_id"
  ],
  "properties": {
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 100,
      "minimum": 1,
      "description": "Maximum number of transcripts to return. The service might return fewer than this value. If unspecified, at most 10 transcripts are returned. The maximum value is 100; values above 100 are coerced to 100."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "description": "Page token returned from a previous list call, used to retrieve the next page of results."
    },
    "conferenceRecord_id": {
      "type": "string",
      "title": "Conference Record Id",
      "examples": [
        "kRyYx8b7vNDsLpR1tG_cNjFUQBoBRhHIMoGJAJkBCQ"
      ],
      "description": "Unique identifier of the conference record. This is the ID portion from the conference record resource name (format: 'conferenceRecords/{id}'). You can obtain valid conference record IDs by using the 'List Conference Records' action or from the 'name' field in conference record responses. Example ID: 'kRyYx8b7vNDsLpR1tG_cNjFUQBoBRhHIMoGJAJkBCQ'. Do NOT pass the full resource name - only the ID portion after 'conferenceRecords/'. A single meeting code can map to multiple conferenceRecord_id values across rejoin sessions; verify the correct record using UTC time or metadata from 'List Conference Records' before calling."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Transcript": {
      "type": "object",
      "title": "Transcript",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the transcript. Format: conferenceRecords/{conferenceRecord}/transcripts/{transcript}"
        },
        "state": {
          "type": "string",
          "title": "State",
          "description": "Current state of the transcript session. Possible values: STATE_UNSPECIFIED (default, never used), STARTED (active transcript session has started), ENDED (transcript session ended but file not generated yet), FILE_GENERATED (transcript file is generated and ready to download)"
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp when the transcript stopped recording (ISO 8601 format)"
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp when the transcript began recording (ISO 8601 format)"
        },
        "docsDestination": {
          "type": "object",
          "title": "Docs Destination",
          "properties": {
            "document": {
              "type": "string",
              "title": "Document",
              "description": "Document ID for the underlying Google Docs transcript file"
            },
            "exportUri": {
              "type": "string",
              "title": "Export Uri",
              "description": "URI for accessing the Google Docs transcript file"
            }
          },
          "description": "Location where the Google Docs transcript is saved"
        }
      },
      "description": "Transcript resource information."
    },
    "DocsDestination": {
      "type": "object",
      "title": "DocsDestination",
      "properties": {
        "document": {
          "type": "string",
          "title": "Document",
          "description": "Document ID for the underlying Google Docs transcript file"
        },
        "exportUri": {
          "type": "string",
          "title": "Export Uri",
          "description": "URI for accessing the Google Docs transcript file"
        }
      },
      "description": "Location where the Google Docs transcript is saved."
    },
    "GetTranscriptsByConferenceRecordIdResponse": {
      "type": "object",
      "title": "GetTranscriptsByConferenceRecordIdResponse",
      "properties": {
        "transcripts": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Transcript",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the transcript. Format: conferenceRecords/{conferenceRecord}/transcripts/{transcript}"
              },
              "state": {
                "type": "string",
                "title": "State",
                "description": "Current state of the transcript session. Possible values: STATE_UNSPECIFIED (default, never used), STARTED (active transcript session has started), ENDED (transcript session ended but file not generated yet), FILE_GENERATED (transcript file is generated and ready to download)"
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp when the transcript stopped recording (ISO 8601 format)"
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp when the transcript began recording (ISO 8601 format)"
              },
              "docsDestination": {
                "type": "object",
                "title": "Docs Destination",
                "properties": {
                  "document": {
                    "type": "string",
                    "title": "Document",
                    "description": "Document ID for the underlying Google Docs transcript file"
                  },
                  "exportUri": {
                    "type": "string",
                    "title": "Export Uri",
                    "description": "URI for accessing the Google Docs transcript file"
                  }
                },
                "description": "Location where the Google Docs transcript is saved"
              }
            },
            "description": "Transcript resource information."
          },
          "title": "Transcripts",
          "description": "List of transcripts in one page."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List doesn't include all the transcripts. Unset if all transcripts are returned."
        }
      },
      "description": "Response containing transcripts for a conference record."
    }
  },
  "title": "GetTranscriptsByConferenceRecordIdResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "transcripts": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Transcript",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the transcript. Format: conferenceRecords/{conferenceRecord}/transcripts/{transcript}"
              },
              "state": {
                "type": "string",
                "title": "State",
                "description": "Current state of the transcript session. Possible values: STATE_UNSPECIFIED (default, never used), STARTED (active transcript session has started), ENDED (transcript session ended but file not generated yet), FILE_GENERATED (transcript file is generated and ready to download)"
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp when the transcript stopped recording (ISO 8601 format)"
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp when the transcript began recording (ISO 8601 format)"
              },
              "docsDestination": {
                "type": "object",
                "title": "Docs Destination",
                "properties": {
                  "document": {
                    "type": "string",
                    "title": "Document",
                    "description": "Document ID for the underlying Google Docs transcript file"
                  },
                  "exportUri": {
                    "type": "string",
                    "title": "Export Uri",
                    "description": "URI for accessing the Google Docs transcript file"
                  }
                },
                "description": "Location where the Google Docs transcript is saved"
              }
            },
            "description": "Transcript resource information."
          },
          "title": "Transcripts",
          "description": "List of transcripts in one page."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List doesn't include all the transcripts. Unset if all transcripts are returned."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_LIST_CONFERENCE_RECORDS
Tool to list conference records. Use when you need to retrieve a list of past conferences, optionally filtering them by criteria like meeting code, space name, or time range.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListConferenceRecordsRequest",
  "properties": {
    "filter": {
      "type": "string",
      "title": "Filter",
      "description": "Optional. User specified filtering condition in EBNF format. Filterable fields: `space.meeting_code`, `space.name`, `start_time`, `end_time`. Examples: `space.name = \"spaces/NAME\"`, `space.meeting_code = \"abc-mnop-xyz\"`, `start_time>=\"2024-01-01T00:00:00.000Z\" AND start_time<=\"2024-01-02T00:00:00.000Z\"`, `end_time IS NULL` Time values must be RFC3339 UTC (e.g., `2024-01-01T00:00:00.000Z`); non-UTC timezones or reversed bounds silently omit records. Unsupported fields or malformed expressions silently return empty or over-narrowed results. A single `space.meeting_code` may match multiple records if the code was reused; combine with time filters to isolate the target record."
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 100,
      "minimum": 1,
      "description": "Maximum number of conference records to return. The service might return fewer than this value. If unspecified, at most 25 conference records are returned. The maximum value is 100; values above 100 are coerced to 100."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "description": "Page token returned from previous List Call. Loop using the returned `page_token` until no token is returned to retrieve the complete result set."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ConferenceRecord": {
      "type": "object",
      "title": "ConferenceRecord",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the conference record. Format: `conferenceRecords/{conference_record}` where `{conference_record}` is a unique ID."
        },
        "space": {
          "type": "string",
          "title": "Space",
          "description": "The space where the conference was held. Resource name format: spaces/{space}"
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp when the conference ended."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp when the conference started."
        },
        "expireTime": {
          "type": "string",
          "title": "Expire Time",
          "description": "Timestamp when the conference record is deleted. See [Google Meet retention policy](https://support.google.com/meet/answer/10697001) for more details."
        }
      }
    },
    "ListConferenceRecordsResponse": {
      "type": "object",
      "title": "ListConferenceRecordsResponse",
      "properties": {
        "next_page_token": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List does NOT include all the Conferences. Unset if all conferences have been returned."
        },
        "conference_records": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ConferenceRecord",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the conference record. Format: `conferenceRecords/{conference_record}` where `{conference_record}` is a unique ID."
              },
              "space": {
                "type": "string",
                "title": "Space",
                "description": "The space where the conference was held. Resource name format: spaces/{space}"
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp when the conference ended."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp when the conference started."
              },
              "expireTime": {
                "type": "string",
                "title": "Expire Time",
                "description": "Timestamp when the conference record is deleted. See [Google Meet retention policy](https://support.google.com/meet/answer/10697001) for more details."
              }
            }
          },
          "title": "Conference Records",
          "description": "List of conferences in one page."
        }
      }
    }
  },
  "title": "ListConferenceRecordsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "next_page_token": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List does NOT include all the Conferences. Unset if all conferences have been returned."
        },
        "conference_records": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ConferenceRecord",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the conference record. Format: `conferenceRecords/{conference_record}` where `{conference_record}` is a unique ID."
              },
              "space": {
                "type": "string",
                "title": "Space",
                "description": "The space where the conference was held. Resource name format: spaces/{space}"
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp when the conference ended."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp when the conference started."
              },
              "expireTime": {
                "type": "string",
                "title": "Expire Time",
                "description": "Timestamp when the conference record is deleted. See [Google Meet retention policy](https://support.google.com/meet/answer/10697001) for more details."
              }
            }
          },
          "title": "Conference Records",
          "description": "List of conferences in one page."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_LIST_PARTICIPANTS
Lists the participants in a conference record. By default, ordered by join time descending. Use to retrieve all participants who joined a specific Google Meet conference, with support for filtering active participants (where `latest_end_time IS NULL`).

**Input schema:**
```json
{
  "type": "object",
  "title": "ListParticipantsRequest",
  "required": [
    "parent"
  ],
  "properties": {
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "latest_end_time IS NULL"
      ],
      "description": "Optional. User-specified filtering condition in EBNF format. Filterable fields: `earliest_start_time`, `latest_end_time`. Example: `latest_end_time IS NULL` returns active participants in the conference."
    },
    "parent": {
      "type": "string",
      "title": "Parent",
      "examples": [
        "conferenceRecords/abc-123-def"
      ],
      "description": "Required. Format: conferenceRecords/{conference_record}. The conference record ID can be obtained from the LIST_CONFERENCE_RECORDS action."
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 250,
      "minimum": 1,
      "examples": [
        100
      ],
      "description": "Optional. Maximum number of participants to return. The service might return fewer than this value. If unspecified, at most 100 participants are returned. The maximum value is 250; values above 250 are coerced to 250."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "examples": [
        "CiAKGjBpNDBibWxqNGx..."
      ],
      "description": "Optional. Page token returned from a previous list call, used to retrieve the next page of results."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "PhoneUser": {
      "type": "object",
      "title": "PhoneUser",
      "properties": {
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "User's display name that's visible in the Google Meet app."
        }
      }
    },
    "Participant": {
      "type": "object",
      "title": "Participant",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the participant. Format: `conferenceRecords/{conferenceRecord}/participants/{participant}`"
        },
        "phoneUser": {
          "type": "object",
          "title": "Phone User",
          "properties": {
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "User's display name that's visible in the Google Meet app."
            }
          },
          "description": "User who joins from their phone."
        },
        "signedInUser": {
          "type": "object",
          "title": "Signed In User",
          "properties": {
            "userId": {
              "type": "string",
              "title": "User Id",
              "description": "Unique ID for the user."
            },
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "For people from Google Workspace organizations, this is the user's display name. For other types of users, this is the user's name that's visible in the Google Meet app."
            }
          },
          "description": "Signed-in user."
        },
        "anonymousUser": {
          "type": "object",
          "title": "Anonymous User",
          "properties": {
            "displayName": {
              "type": "string",
              "title": "Display Name",
              "description": "User's display name that's visible in the Google Meet app."
            }
          },
          "description": "Anonymous user."
        },
        "latestEndTime": {
          "type": "string",
          "title": "Latest End Time",
          "description": "Time when the participant left the meeting for the last time. Unset if the participant is still in the meeting."
        },
        "earliestStartTime": {
          "type": "string",
          "title": "Earliest Start Time",
          "description": "Time when the participant first joined the meeting."
        }
      }
    },
    "SignedinUser": {
      "type": "object",
      "title": "SignedinUser",
      "properties": {
        "userId": {
          "type": "string",
          "title": "User Id",
          "description": "Unique ID for the user."
        },
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "For people from Google Workspace organizations, this is the user's display name. For other types of users, this is the user's name that's visible in the Google Meet app."
        }
      }
    },
    "AnonymousUser": {
      "type": "object",
      "title": "AnonymousUser",
      "properties": {
        "displayName": {
          "type": "string",
          "title": "Display Name",
          "description": "User's display name that's visible in the Google Meet app."
        }
      }
    },
    "ListParticipantsResponse": {
      "type": "object",
      "title": "ListParticipantsResponse",
      "properties": {
        "totalSize": {
          "type": "integer",
          "title": "Total Size",
          "description": "Total number of participants. Set only in the first response."
        },
        "participants": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Participant",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the participant. Format: `conferenceRecords/{conferenceRecord}/participants/{participant}`"
              },
              "phoneUser": {
                "type": "object",
                "title": "Phone User",
                "properties": {
                  "displayName": {
                    "type": "string",
                    "title": "Display Name",
                    "description": "User's display name that's visible in the Google Meet app."
                  }
                },
                "description": "User who joins from their phone."
              },
              "signedInUser": {
                "type": "object",
                "title": "Signed In User",
                "properties": {
                  "userId": {
                    "type": "string",
                    "title": "User Id",
                    "description": "Unique ID for the user."
                  },
                  "displayName": {
                    "type": "string",
                    "title": "Display Name",
                    "description": "For people from Google Workspace organizations, this is the user's display name. For other types of users, this is the user's name that's visible in the Google Meet app."
                  }
                },
                "description": "Signed-in user."
              },
              "anonymousUser": {
                "type": "object",
                "title": "Anonymous User",
                "properties": {
                  "displayName": {
                    "type": "string",
                    "title": "Display Name",
                    "description": "User's display name that's visible in the Google Meet app."
                  }
                },
                "description": "Anonymous user."
              },
              "latestEndTime": {
                "type": "string",
                "title": "Latest End Time",
                "description": "Time when the participant left the meeting for the last time. Unset if the participant is still in the meeting."
              },
              "earliestStartTime": {
                "type": "string",
                "title": "Earliest Start Time",
                "description": "Time when the participant first joined the meeting."
              }
            }
          },
          "title": "Participants",
          "description": "List of participants in one page."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List doesn't include all the participants. Unset if all participants have been returned."
        }
      }
    }
  },
  "title": "ListParticipantsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "totalSize": {
          "type": "integer",
          "title": "Total Size",
          "description": "Total number of participants. Set only in the first response."
        },
        "participants": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Participant",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the participant. Format: `conferenceRecords/{conferenceRecord}/participants/{participant}`"
              },
              "phoneUser": {
                "type": "object",
                "title": "Phone User",
                "properties": {
                  "displayName": {
                    "type": "string",
                    "title": "Display Name",
                    "description": "User's display name that's visible in the Google Meet app."
                  }
                },
                "description": "User who joins from their phone."
              },
              "signedInUser": {
                "type": "object",
                "title": "Signed In User",
                "properties": {
                  "userId": {
                    "type": "string",
                    "title": "User Id",
                    "description": "Unique ID for the user."
                  },
                  "displayName": {
                    "type": "string",
                    "title": "Display Name",
                    "description": "For people from Google Workspace organizations, this is the user's display name. For other types of users, this is the user's name that's visible in the Google Meet app."
                  }
                },
                "description": "Signed-in user."
              },
              "anonymousUser": {
                "type": "object",
                "title": "Anonymous User",
                "properties": {
                  "displayName": {
                    "type": "string",
                    "title": "Display Name",
                    "description": "User's display name that's visible in the Google Meet app."
                  }
                },
                "description": "Anonymous user."
              },
              "latestEndTime": {
                "type": "string",
                "title": "Latest End Time",
                "description": "Time when the participant left the meeting for the last time. Unset if the participant is still in the meeting."
              },
              "earliestStartTime": {
                "type": "string",
                "title": "Earliest Start Time",
                "description": "Time when the participant first joined the meeting."
              }
            }
          },
          "title": "Participants",
          "description": "List of participants in one page."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List doesn't include all the participants. Unset if all participants have been returned."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_LIST_PARTICIPANT_SESSIONS
Lists all participant sessions for a specific participant in a Google Meet conference. A participant session represents each unique join or leave session when a user joins a conference from a device. If a user joins multiple times from the same device, each join creates a new session. Returns session details including start time and end time for each session.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListParticipantSessionsRequest",
  "required": [
    "conference_record_id",
    "participant_id"
  ],
  "properties": {
    "filter": {
      "type": "string",
      "title": "Filter",
      "examples": [
        "end_time IS NULL"
      ],
      "description": "Optional. User-specified filtering condition in EBNF format. Filterable fields include `start_time` and `end_time`. Time values must use RFC3339 UTC format (e.g., `start_time >= '2024-01-01T00:00:00Z'`). Unsupported field names or malformed expressions may silently narrow or drop results rather than raising errors. Reversed bounds or incorrect timezone conversion will produce empty results."
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 250,
      "minimum": 1,
      "examples": [
        100
      ],
      "description": "Optional. Maximum number of participant sessions to return. The service might return fewer than this value. If unspecified, at most 100 participant sessions are returned. The maximum value is 250; values above 250 are coerced to 250."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "examples": [
        "CiAKGjBpNDBibWxqNGx..."
      ],
      "description": "Optional. Page token returned from a previous list call, used to retrieve the next page of results. Iterate using successive `page_token` values until the response omits `page_token` to avoid silently missing sessions."
    },
    "participant_id": {
      "type": "string",
      "title": "Participant Id",
      "examples": [
        "xyz-456"
      ],
      "description": "Required. The unique identifier of the participant within the conference. Example: 'xyz-456'."
    },
    "conference_record_id": {
      "type": "string",
      "title": "Conference Record Id",
      "examples": [
        "abc-123-def"
      ],
      "description": "Required. The unique identifier of the conference record. Example: 'abc-123-def'."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ParticipantSession": {
      "type": "object",
      "title": "ParticipantSession",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Identifier. Session id in the format `conferenceRecords/{conferenceRecord}/participants/{participant}/participantSessions/{participantSession}`."
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Output only. Timestamp when the user session ends. Unset if the user session hasn't ended."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Output only. Timestamp when the user session starts."
        }
      }
    },
    "ListParticipantSessionsResponse": {
      "type": "object",
      "title": "ListParticipantSessionsResponse",
      "properties": {
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List doesn't include all the participant sessions. Unset if all participant sessions are returned."
        },
        "participantSessions": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ParticipantSession",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Identifier. Session id in the format `conferenceRecords/{conferenceRecord}/participants/{participant}/participantSessions/{participantSession}`."
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Output only. Timestamp when the user session ends. Unset if the user session hasn't ended."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Output only. Timestamp when the user session starts."
              }
            }
          },
          "title": "Participant Sessions",
          "description": "List of participant sessions in one page."
        }
      }
    }
  },
  "title": "ListParticipantSessionsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List doesn't include all the participant sessions. Unset if all participant sessions are returned."
        },
        "participantSessions": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ParticipantSession",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Identifier. Session id in the format `conferenceRecords/{conferenceRecord}/participants/{participant}/participantSessions/{participantSession}`."
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Output only. Timestamp when the user session ends. Unset if the user session hasn't ended."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Output only. Timestamp when the user session starts."
              }
            }
          },
          "title": "Participant Sessions",
          "description": "List of participant sessions in one page."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_LIST_RECORDINGS
Tool to list recording resources from a conference record. Use when you need to retrieve recordings from a specific Google Meet conference. Recordings are created when meeting recording is enabled and saved to Google Drive as MP4 files.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListRecordingsRequest",
  "required": [
    "parent"
  ],
  "properties": {
    "parent": {
      "type": "string",
      "title": "Parent",
      "examples": [
        "conferenceRecords/GLkPdCDLsjSXet2-QH9dDxIPOAIIigIgABgECA"
      ],
      "description": "Required. The conference record to list recordings for. Format: conferenceRecords/{conference_record}"
    },
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 100,
      "minimum": 1,
      "description": "Maximum number of recordings to return. The service may return fewer than this value. If unspecified, at most 10 recordings are returned. The maximum value is 100; values above 100 are coerced to 100."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "description": "Page token returned from a previous list call. Provide this to retrieve the subsequent page. When paginating, all other parameters provided to the list call must match the call that provided the page token."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Recording": {
      "type": "object",
      "title": "Recording",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the recording. Format: conferenceRecords/{conferenceRecord}/recordings/{recording}. Output only."
        },
        "state": {
          "type": "string",
          "title": "State",
          "description": "Current state of the recording. Possible values: STATE_UNSPECIFIED, STARTED, ENDED, FILE_GENERATED. Output only."
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp when the recording ended. Output only."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp when the recording started. Output only."
        },
        "driveDestination": {
          "type": "object",
          "title": "Drive Destination",
          "properties": {
            "file": {
              "type": "string",
              "title": "File",
              "description": "The fileId for the underlying MP4 file. For use with the Drive API."
            },
            "exportUri": {
              "type": "string",
              "title": "Export Uri",
              "description": "Link used to play back the recording file in the browser."
            }
          },
          "description": "Recording is saved to Google Drive as an MP4 file. Output only."
        }
      },
      "description": "Represents a single recording from a conference."
    },
    "DriveDestination": {
      "type": "object",
      "title": "DriveDestination",
      "properties": {
        "file": {
          "type": "string",
          "title": "File",
          "description": "The fileId for the underlying MP4 file. For use with the Drive API."
        },
        "exportUri": {
          "type": "string",
          "title": "Export Uri",
          "description": "Link used to play back the recording file in the browser."
        }
      },
      "description": "Recording is saved to Google Drive as an MP4 file."
    },
    "ListRecordingsResponse": {
      "type": "object",
      "title": "ListRecordingsResponse",
      "properties": {
        "recordings": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Recording",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the recording. Format: conferenceRecords/{conferenceRecord}/recordings/{recording}. Output only."
              },
              "state": {
                "type": "string",
                "title": "State",
                "description": "Current state of the recording. Possible values: STATE_UNSPECIFIED, STARTED, ENDED, FILE_GENERATED. Output only."
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp when the recording ended. Output only."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp when the recording started. Output only."
              },
              "driveDestination": {
                "type": "object",
                "title": "Drive Destination",
                "properties": {
                  "file": {
                    "type": "string",
                    "title": "File",
                    "description": "The fileId for the underlying MP4 file. For use with the Drive API."
                  },
                  "exportUri": {
                    "type": "string",
                    "title": "Export Uri",
                    "description": "Link used to play back the recording file in the browser."
                  }
                },
                "description": "Recording is saved to Google Drive as an MP4 file. Output only."
              }
            },
            "description": "Represents a single recording from a conference."
          },
          "title": "Recordings",
          "description": "List of recordings. By default, ordered by start time and in ascending order."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to retrieve the next page of results. If this field is omitted, there are no subsequent pages."
        }
      },
      "description": "Response containing a list of recordings and optional pagination token."
    }
  },
  "title": "ListRecordingsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "recordings": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Recording",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource name of the recording. Format: conferenceRecords/{conferenceRecord}/recordings/{recording}. Output only."
              },
              "state": {
                "type": "string",
                "title": "State",
                "description": "Current state of the recording. Possible values: STATE_UNSPECIFIED, STARTED, ENDED, FILE_GENERATED. Output only."
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp when the recording ended. Output only."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp when the recording started. Output only."
              },
              "driveDestination": {
                "type": "object",
                "title": "Drive Destination",
                "properties": {
                  "file": {
                    "type": "string",
                    "title": "File",
                    "description": "The fileId for the underlying MP4 file. For use with the Drive API."
                  },
                  "exportUri": {
                    "type": "string",
                    "title": "Export Uri",
                    "description": "Link used to play back the recording file in the browser."
                  }
                },
                "description": "Recording is saved to Google Drive as an MP4 file. Output only."
              }
            },
            "description": "Represents a single recording from a conference."
          },
          "title": "Recordings",
          "description": "List of recordings. By default, ordered by start time and in ascending order."
        },
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to retrieve the next page of results. If this field is omitted, there are no subsequent pages."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_LIST_TRANSCRIPT_ENTRIES
Tool to list structured transcript entries (speaker/time/text segments) for a specific Google Meet transcript. Use when you need to access the detailed content of a transcript, including individual spoken segments with timestamps and speaker information. Note: The transcript entries returned by the API might not match the transcription in Google Docs due to interleaved speakers or post-generation modifications.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListTranscriptEntriesRequest",
  "required": [
    "conference_record_id",
    "transcript_id"
  ],
  "properties": {
    "page_size": {
      "type": "integer",
      "title": "Page Size",
      "maximum": 100,
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "Maximum number of transcript entries to return. The service might return fewer than this value. If unspecified, at most 10 entries are returned. The maximum value is 100; values above 100 are coerced to 100."
    },
    "page_token": {
      "type": "string",
      "title": "Page Token",
      "examples": [
        "CiAKGjBpNDBibWxqNGx..."
      ],
      "description": "Page token returned from a previous list call, used to retrieve the next page of results."
    },
    "transcript_id": {
      "type": "string",
      "title": "Transcript Id",
      "examples": [
        "xyz-456"
      ],
      "description": "The unique identifier of the transcript within the conference record."
    },
    "conference_record_id": {
      "type": "string",
      "title": "Conference Record Id",
      "examples": [
        "abc-123-def"
      ],
      "description": "The unique identifier of the conference record."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "TranscriptEntry": {
      "type": "object",
      "title": "TranscriptEntry",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource identifier formatted as 'conferenceRecords/{conferenceRecord}/transcripts/{transcript}/entries/{entry}'."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The transcribed text of the participant's voice, at maximum 10K words."
        },
        "endTime": {
          "type": "string",
          "title": "End Time",
          "description": "Timestamp indicating when the entry concluded."
        },
        "startTime": {
          "type": "string",
          "title": "Start Time",
          "description": "Timestamp indicating when the entry began."
        },
        "participant": {
          "type": "string",
          "title": "Participant",
          "description": "Refers to the participant who speaks. Format: 'conferenceRecords/{conferenceRecord}/participants/{participant}'."
        },
        "languageCode": {
          "type": "string",
          "title": "Language Code",
          "description": "Language of spoken text, such as 'en-US'. IETF BCP 47 syntax."
        }
      }
    },
    "ListTranscriptEntriesResponse": {
      "type": "object",
      "title": "ListTranscriptEntriesResponse",
      "properties": {
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List doesn't include all the transcript entries. Unset if all entries are returned."
        },
        "transcriptEntries": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "TranscriptEntry",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource identifier formatted as 'conferenceRecords/{conferenceRecord}/transcripts/{transcript}/entries/{entry}'."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The transcribed text of the participant's voice, at maximum 10K words."
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp indicating when the entry concluded."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp indicating when the entry began."
              },
              "participant": {
                "type": "string",
                "title": "Participant",
                "description": "Refers to the participant who speaks. Format: 'conferenceRecords/{conferenceRecord}/participants/{participant}'."
              },
              "languageCode": {
                "type": "string",
                "title": "Language Code",
                "description": "Language of spoken text, such as 'en-US'. IETF BCP 47 syntax."
              }
            }
          },
          "title": "Transcript Entries",
          "description": "List of transcript entries in one page. Ordered by start time in ascending order."
        }
      }
    }
  },
  "title": "ListTranscriptEntriesResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "nextPageToken": {
          "type": "string",
          "title": "Next Page Token",
          "description": "Token to be circulated back for further List call if current List doesn't include all the transcript entries. Unset if all entries are returned."
        },
        "transcriptEntries": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "TranscriptEntry",
            "properties": {
              "name": {
                "type": "string",
                "title": "Name",
                "description": "Resource identifier formatted as 'conferenceRecords/{conferenceRecord}/transcripts/{transcript}/entries/{entry}'."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The transcribed text of the participant's voice, at maximum 10K words."
              },
              "endTime": {
                "type": "string",
                "title": "End Time",
                "description": "Timestamp indicating when the entry concluded."
              },
              "startTime": {
                "type": "string",
                "title": "Start Time",
                "description": "Timestamp indicating when the entry began."
              },
              "participant": {
                "type": "string",
                "title": "Participant",
                "description": "Refers to the participant who speaks. Format: 'conferenceRecords/{conferenceRecord}/participants/{participant}'."
              },
              "languageCode": {
                "type": "string",
                "title": "Language Code",
                "description": "Language of spoken text, such as 'en-US'. IETF BCP 47 syntax."
              }
            }
          },
          "title": "Transcript Entries",
          "description": "List of transcript entries in one page. Ordered by start time in ascending order."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```

## GOOGLEMEET_UPDATE_SPACE
Updates the settings of an existing Google Meet space. Requires organizer/host privileges and the meetings.space.created OAuth scope. REQUIRED PARAMETER: - name: The space identifier (e.g., 'spaces/jQCFfuBOdN5z'). This is always required to identify which space to update. OPTIONAL PARAMETERS: - config: The new configuration settings to apply (accessType, entryPointAccess, moderation, etc.) - updateMask: Specify which fields to update. If omitted, all provided config fields are updated. Example: To change access type, provide name='spaces/abc123' and config={'accessType': 'OPEN'}

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateSpaceRequest",
  "required": [
    "name"
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Name",
      "examples": [
        "spaces/jQCFfuBOdN5z"
      ],
      "description": "REQUIRED. The unique identifier of the Google Meet space to update. Format: 'spaces/{space}' where {space} is the space ID."
    },
    "config": {
      "type": "object",
      "title": "SpaceConfig",
      "properties": {
        "accessType": {
          "enum": [
            "ACCESS_TYPE_UNSPECIFIED",
            "OPEN",
            "TRUSTED",
            "RESTRICTED"
          ],
          "type": "string",
          "title": "AccessType",
          "description": "Access type of the meeting space."
        },
        "moderation": {
          "enum": [
            "MODERATION_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "ModerationMode",
          "description": "The pre-configured moderation mode for the Meeting."
        },
        "artifactConfig": {
          "type": "object",
          "title": "ArtifactConfig",
          "properties": {
            "recordingConfig": {
              "type": "object",
              "title": "RecordingConfig",
              "properties": {
                "autoRecordingGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "AutoGenerationType",
                  "description": "Defines whether a meeting space is automatically recorded."
                }
              },
              "description": "Configuration for recording.",
              "additionalProperties": false
            },
            "smartNotesConfig": {
              "type": "object",
              "title": "SmartNotesConfig",
              "properties": {
                "autoSmartNotesGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "AutoGenerationType",
                  "description": "Defines whether to automatically generate a summary and recap of the meeting."
                }
              },
              "description": "Configuration for auto-smart-notes. Note: This object only contains recording, transcription, and smart notes configs - NOT attendance report settings.",
              "additionalProperties": false
            },
            "transcriptionConfig": {
              "type": "object",
              "title": "TranscriptionConfig",
              "properties": {
                "autoTranscriptionGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "AutoGenerationType",
                  "description": "Defines whether the content of a meeting is automatically transcribed."
                }
              },
              "description": "Configuration for auto-transcript.",
              "additionalProperties": false
            }
          },
          "description": "Configuration pertaining to the auto-generated artifacts.",
          "additionalProperties": false
        },
        "entryPointAccess": {
          "enum": [
            "ENTRY_POINT_ACCESS_UNSPECIFIED",
            "ALL",
            "CREATOR_APP_ONLY"
          ],
          "type": "string",
          "title": "EntryPointAccess",
          "description": "Defines the entry points that can be used to join meetings."
        },
        "moderationRestrictions": {
          "type": "object",
          "title": "ModerationRestrictions",
          "properties": {
            "chatRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "RestrictionType",
              "description": "Defines who has permission to send chat messages."
            },
            "presentRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "RestrictionType",
              "description": "Defines who has permission to share their screen."
            },
            "reactionRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "RestrictionType",
              "description": "Defines who has permission to send reactions."
            },
            "defaultJoinAsViewerType": {
              "enum": [
                "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "DefaultJoinAsViewerType",
              "description": "Defines whether to restrict the default role assigned to users as viewer."
            }
          },
          "description": "When moderation.ON, these restrictions go into effect.",
          "additionalProperties": false
        },
        "attendanceReportGenerationType": {
          "enum": [
            "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
            "GENERATE_REPORT",
            "DO_NOT_GENERATE"
          ],
          "type": "string",
          "title": "AttendanceReportGenerationType",
          "description": "Whether attendance report is enabled for the meeting space. This is a top-level config field, NOT part of artifactConfig."
        }
      },
      "description": "Configuration settings to update for the meeting space. Provide the fields you want to modify (e.g., accessType, entryPointAccess, moderation settings). Some settings (moderation modes, attendanceReportGenerationType, artifact generation) require specific Google Workspace editions and admin policies; unsupported settings may apply silently with no effect. Certain combinations of accessType, entryPointAccess, or moderation values may be rejected based on domain or account policies.",
      "additionalProperties": false
    },
    "updateMask": {
      "type": "string",
      "title": "Update Mask",
      "examples": [
        "config.accessType",
        "config.accessType,config.entryPointAccess"
      ],
      "description": "Field mask specifying which fields to update. Comma-separated list of fully qualified field names (e.g., \"config.accessType,config.entryPointAccess\"). If not provided, only the fields you explicitly set in config will be updated. WARNING: Using \"*\" will attempt to update ALL config fields, which may cause errors if required fields like attendanceReportGenerationType are not provided. Recommend specifying only the fields being updated."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "AccessType": {
      "enum": [
        "ACCESS_TYPE_UNSPECIFIED",
        "OPEN",
        "TRUSTED",
        "RESTRICTED"
      ],
      "type": "string",
      "title": "AccessType"
    },
    "SpaceConfig": {
      "type": "object",
      "title": "SpaceConfig",
      "properties": {
        "accessType": {
          "enum": [
            "ACCESS_TYPE_UNSPECIFIED",
            "OPEN",
            "TRUSTED",
            "RESTRICTED"
          ],
          "type": "string",
          "title": "Access Type",
          "description": "Access type of the meeting space."
        },
        "moderation": {
          "enum": [
            "MODERATION_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Moderation",
          "description": "The pre-configured moderation mode for the Meeting."
        },
        "artifactConfig": {
          "type": "object",
          "title": "Artifact Config",
          "properties": {
            "recordingConfig": {
              "type": "object",
              "title": "Recording Config",
              "properties": {
                "autoRecordingGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Auto Recording Generation",
                  "description": "Defines whether a meeting space is automatically recorded."
                }
              },
              "description": "Configuration for recording."
            },
            "smartNotesConfig": {
              "type": "object",
              "title": "Smart Notes Config",
              "properties": {
                "autoSmartNotesGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Auto Smart Notes Generation",
                  "description": "Defines whether to automatically generate a summary and recap of the meeting."
                }
              },
              "description": "Configuration for auto-smart-notes. Note: This object only contains recording, transcription, and smart notes configs - NOT attendance report settings."
            },
            "transcriptionConfig": {
              "type": "object",
              "title": "Transcription Config",
              "properties": {
                "autoTranscriptionGeneration": {
                  "enum": [
                    "AUTO_GENERATION_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Auto Transcription Generation",
                  "description": "Defines whether the content of a meeting is automatically transcribed."
                }
              },
              "description": "Configuration for auto-transcript."
            }
          },
          "description": "Configuration pertaining to the auto-generated artifacts."
        },
        "entryPointAccess": {
          "enum": [
            "ENTRY_POINT_ACCESS_UNSPECIFIED",
            "ALL",
            "CREATOR_APP_ONLY"
          ],
          "type": "string",
          "title": "Entry Point Access",
          "description": "Defines the entry points that can be used to join meetings."
        },
        "moderationRestrictions": {
          "type": "object",
          "title": "Moderation Restrictions",
          "properties": {
            "chatRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "Chat Restriction",
              "description": "Defines who has permission to send chat messages."
            },
            "presentRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "Present Restriction",
              "description": "Defines who has permission to share their screen."
            },
            "reactionRestriction": {
              "enum": [
                "RESTRICTION_TYPE_UNSPECIFIED",
                "NO_RESTRICTION",
                "HOSTS_ONLY"
              ],
              "type": "string",
              "title": "Reaction Restriction",
              "description": "Defines who has permission to send reactions."
            },
            "defaultJoinAsViewerType": {
              "enum": [
                "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Default Join As Viewer Type",
              "description": "Defines whether to restrict the default role assigned to users as viewer."
            }
          },
          "description": "When moderation.ON, these restrictions go into effect."
        },
        "attendanceReportGenerationType": {
          "enum": [
            "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
            "GENERATE_REPORT",
            "DO_NOT_GENERATE"
          ],
          "type": "string",
          "title": "Attendance Report Generation Type",
          "description": "Whether attendance report is enabled for the meeting space. This is a top-level config field, NOT part of artifactConfig."
        }
      }
    },
    "ArtifactConfig": {
      "type": "object",
      "title": "ArtifactConfig",
      "properties": {
        "recordingConfig": {
          "type": "object",
          "title": "Recording Config",
          "properties": {
            "autoRecordingGeneration": {
              "enum": [
                "AUTO_GENERATION_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Auto Recording Generation",
              "description": "Defines whether a meeting space is automatically recorded."
            }
          },
          "description": "Configuration for recording."
        },
        "smartNotesConfig": {
          "type": "object",
          "title": "Smart Notes Config",
          "properties": {
            "autoSmartNotesGeneration": {
              "enum": [
                "AUTO_GENERATION_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Auto Smart Notes Generation",
              "description": "Defines whether to automatically generate a summary and recap of the meeting."
            }
          },
          "description": "Configuration for auto-smart-notes. Note: This object only contains recording, transcription, and smart notes configs - NOT attendance report settings."
        },
        "transcriptionConfig": {
          "type": "object",
          "title": "Transcription Config",
          "properties": {
            "autoTranscriptionGeneration": {
              "enum": [
                "AUTO_GENERATION_TYPE_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Auto Transcription Generation",
              "description": "Defines whether the content of a meeting is automatically transcribed."
            }
          },
          "description": "Configuration for auto-transcript."
        }
      }
    },
    "ModerationMode": {
      "enum": [
        "MODERATION_UNSPECIFIED",
        "OFF",
        "ON"
      ],
      "type": "string",
      "title": "ModerationMode"
    },
    "RecordingConfig": {
      "type": "object",
      "title": "RecordingConfig",
      "properties": {
        "autoRecordingGeneration": {
          "enum": [
            "AUTO_GENERATION_TYPE_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Auto Recording Generation",
          "description": "Defines whether a meeting space is automatically recorded."
        }
      }
    },
    "RestrictionType": {
      "enum": [
        "RESTRICTION_TYPE_UNSPECIFIED",
        "NO_RESTRICTION",
        "HOSTS_ONLY"
      ],
      "type": "string",
      "title": "RestrictionType"
    },
    "ActiveConference": {
      "type": "object",
      "title": "ActiveConference",
      "properties": {
        "conferenceRecord": {
          "type": "string",
          "title": "Conference Record",
          "description": "Reference to 'ConferenceRecord' resource."
        }
      }
    },
    "EntryPointAccess": {
      "enum": [
        "ENTRY_POINT_ACCESS_UNSPECIFIED",
        "ALL",
        "CREATOR_APP_ONLY"
      ],
      "type": "string",
      "title": "EntryPointAccess"
    },
    "SmartNotesConfig": {
      "type": "object",
      "title": "SmartNotesConfig",
      "properties": {
        "autoSmartNotesGeneration": {
          "enum": [
            "AUTO_GENERATION_TYPE_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Auto Smart Notes Generation",
          "description": "Defines whether to automatically generate a summary and recap of the meeting."
        }
      }
    },
    "AutoGenerationType": {
      "enum": [
        "AUTO_GENERATION_TYPE_UNSPECIFIED",
        "OFF",
        "ON"
      ],
      "type": "string",
      "title": "AutoGenerationType"
    },
    "TranscriptionConfig": {
      "type": "object",
      "title": "TranscriptionConfig",
      "properties": {
        "autoTranscriptionGeneration": {
          "enum": [
            "AUTO_GENERATION_TYPE_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Auto Transcription Generation",
          "description": "Defines whether the content of a meeting is automatically transcribed."
        }
      }
    },
    "UpdateSpaceResponse": {
      "type": "object",
      "title": "UpdateSpaceResponse",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the space."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "properties": {
            "accessType": {
              "enum": [
                "ACCESS_TYPE_UNSPECIFIED",
                "OPEN",
                "TRUSTED",
                "RESTRICTED"
              ],
              "type": "string",
              "title": "Access Type",
              "description": "Access type of the meeting space."
            },
            "moderation": {
              "enum": [
                "MODERATION_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Moderation",
              "description": "The pre-configured moderation mode for the Meeting."
            },
            "artifactConfig": {
              "type": "object",
              "title": "Artifact Config",
              "properties": {
                "recordingConfig": {
                  "type": "object",
                  "title": "Recording Config",
                  "properties": {
                    "autoRecordingGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Recording Generation",
                      "description": "Defines whether a meeting space is automatically recorded."
                    }
                  },
                  "description": "Configuration for recording."
                },
                "smartNotesConfig": {
                  "type": "object",
                  "title": "Smart Notes Config",
                  "properties": {
                    "autoSmartNotesGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Smart Notes Generation",
                      "description": "Defines whether to automatically generate a summary and recap of the meeting."
                    }
                  },
                  "description": "Configuration for auto-smart-notes. Note: This object only contains recording, transcription, and smart notes configs - NOT attendance report settings."
                },
                "transcriptionConfig": {
                  "type": "object",
                  "title": "Transcription Config",
                  "properties": {
                    "autoTranscriptionGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Transcription Generation",
                      "description": "Defines whether the content of a meeting is automatically transcribed."
                    }
                  },
                  "description": "Configuration for auto-transcript."
                }
              },
              "description": "Configuration pertaining to the auto-generated artifacts."
            },
            "entryPointAccess": {
              "enum": [
                "ENTRY_POINT_ACCESS_UNSPECIFIED",
                "ALL",
                "CREATOR_APP_ONLY"
              ],
              "type": "string",
              "title": "Entry Point Access",
              "description": "Defines the entry points that can be used to join meetings."
            },
            "moderationRestrictions": {
              "type": "object",
              "title": "Moderation Restrictions",
              "properties": {
                "chatRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Chat Restriction",
                  "description": "Defines who has permission to send chat messages."
                },
                "presentRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Present Restriction",
                  "description": "Defines who has permission to share their screen."
                },
                "reactionRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Reaction Restriction",
                  "description": "Defines who has permission to send reactions."
                },
                "defaultJoinAsViewerType": {
                  "enum": [
                    "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Default Join As Viewer Type",
                  "description": "Defines whether to restrict the default role assigned to users as viewer."
                }
              },
              "description": "When moderation.ON, these restrictions go into effect."
            },
            "attendanceReportGenerationType": {
              "enum": [
                "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
                "GENERATE_REPORT",
                "DO_NOT_GENERATE"
              ],
              "type": "string",
              "title": "Attendance Report Generation Type",
              "description": "Whether attendance report is enabled for the meeting space. This is a top-level config field, NOT part of artifactConfig."
            }
          },
          "description": "Configuration pertaining to the meeting space."
        },
        "meetingUri": {
          "type": "string",
          "title": "Meeting Uri",
          "description": "URI used to join meetings."
        },
        "meetingCode": {
          "type": "string",
          "title": "Meeting Code",
          "description": "Type friendly unique string used to join the meeting."
        },
        "activeConference": {
          "type": "object",
          "title": "Active Conference",
          "properties": {
            "conferenceRecord": {
              "type": "string",
              "title": "Conference Record",
              "description": "Reference to 'ConferenceRecord' resource."
            }
          },
          "description": "Active conference, if it exists."
        }
      }
    },
    "ModerationRestrictions": {
      "type": "object",
      "title": "ModerationRestrictions",
      "properties": {
        "chatRestriction": {
          "enum": [
            "RESTRICTION_TYPE_UNSPECIFIED",
            "NO_RESTRICTION",
            "HOSTS_ONLY"
          ],
          "type": "string",
          "title": "Chat Restriction",
          "description": "Defines who has permission to send chat messages."
        },
        "presentRestriction": {
          "enum": [
            "RESTRICTION_TYPE_UNSPECIFIED",
            "NO_RESTRICTION",
            "HOSTS_ONLY"
          ],
          "type": "string",
          "title": "Present Restriction",
          "description": "Defines who has permission to share their screen."
        },
        "reactionRestriction": {
          "enum": [
            "RESTRICTION_TYPE_UNSPECIFIED",
            "NO_RESTRICTION",
            "HOSTS_ONLY"
          ],
          "type": "string",
          "title": "Reaction Restriction",
          "description": "Defines who has permission to send reactions."
        },
        "defaultJoinAsViewerType": {
          "enum": [
            "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
            "OFF",
            "ON"
          ],
          "type": "string",
          "title": "Default Join As Viewer Type",
          "description": "Defines whether to restrict the default role assigned to users as viewer."
        }
      }
    },
    "DefaultJoinAsViewerType": {
      "enum": [
        "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
        "OFF",
        "ON"
      ],
      "type": "string",
      "title": "DefaultJoinAsViewerType"
    },
    "AttendanceReportGenerationType": {
      "enum": [
        "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
        "GENERATE_REPORT",
        "DO_NOT_GENERATE"
      ],
      "type": "string",
      "title": "AttendanceReportGenerationType"
    }
  },
  "title": "UpdateSpaceResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "name": {
          "type": "string",
          "title": "Name",
          "description": "Resource name of the space."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "properties": {
            "accessType": {
              "enum": [
                "ACCESS_TYPE_UNSPECIFIED",
                "OPEN",
                "TRUSTED",
                "RESTRICTED"
              ],
              "type": "string",
              "title": "Access Type",
              "description": "Access type of the meeting space."
            },
            "moderation": {
              "enum": [
                "MODERATION_UNSPECIFIED",
                "OFF",
                "ON"
              ],
              "type": "string",
              "title": "Moderation",
              "description": "The pre-configured moderation mode for the Meeting."
            },
            "artifactConfig": {
              "type": "object",
              "title": "Artifact Config",
              "properties": {
                "recordingConfig": {
                  "type": "object",
                  "title": "Recording Config",
                  "properties": {
                    "autoRecordingGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Recording Generation",
                      "description": "Defines whether a meeting space is automatically recorded."
                    }
                  },
                  "description": "Configuration for recording."
                },
                "smartNotesConfig": {
                  "type": "object",
                  "title": "Smart Notes Config",
                  "properties": {
                    "autoSmartNotesGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Smart Notes Generation",
                      "description": "Defines whether to automatically generate a summary and recap of the meeting."
                    }
                  },
                  "description": "Configuration for auto-smart-notes. Note: This object only contains recording, transcription, and smart notes configs - NOT attendance report settings."
                },
                "transcriptionConfig": {
                  "type": "object",
                  "title": "Transcription Config",
                  "properties": {
                    "autoTranscriptionGeneration": {
                      "enum": [
                        "AUTO_GENERATION_TYPE_UNSPECIFIED",
                        "OFF",
                        "ON"
                      ],
                      "type": "string",
                      "title": "Auto Transcription Generation",
                      "description": "Defines whether the content of a meeting is automatically transcribed."
                    }
                  },
                  "description": "Configuration for auto-transcript."
                }
              },
              "description": "Configuration pertaining to the auto-generated artifacts."
            },
            "entryPointAccess": {
              "enum": [
                "ENTRY_POINT_ACCESS_UNSPECIFIED",
                "ALL",
                "CREATOR_APP_ONLY"
              ],
              "type": "string",
              "title": "Entry Point Access",
              "description": "Defines the entry points that can be used to join meetings."
            },
            "moderationRestrictions": {
              "type": "object",
              "title": "Moderation Restrictions",
              "properties": {
                "chatRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Chat Restriction",
                  "description": "Defines who has permission to send chat messages."
                },
                "presentRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Present Restriction",
                  "description": "Defines who has permission to share their screen."
                },
                "reactionRestriction": {
                  "enum": [
                    "RESTRICTION_TYPE_UNSPECIFIED",
                    "NO_RESTRICTION",
                    "HOSTS_ONLY"
                  ],
                  "type": "string",
                  "title": "Reaction Restriction",
                  "description": "Defines who has permission to send reactions."
                },
                "defaultJoinAsViewerType": {
                  "enum": [
                    "DEFAULT_JOIN_AS_VIEWER_TYPE_UNSPECIFIED",
                    "OFF",
                    "ON"
                  ],
                  "type": "string",
                  "title": "Default Join As Viewer Type",
                  "description": "Defines whether to restrict the default role assigned to users as viewer."
                }
              },
              "description": "When moderation.ON, these restrictions go into effect."
            },
            "attendanceReportGenerationType": {
              "enum": [
                "ATTENDANCE_REPORT_GENERATION_TYPE_UNSPECIFIED",
                "GENERATE_REPORT",
                "DO_NOT_GENERATE"
              ],
              "type": "string",
              "title": "Attendance Report Generation Type",
              "description": "Whether attendance report is enabled for the meeting space. This is a top-level config field, NOT part of artifactConfig."
            }
          },
          "description": "Configuration pertaining to the meeting space."
        },
        "meetingUri": {
          "type": "string",
          "title": "Meeting Uri",
          "description": "URI used to join meetings."
        },
        "meetingCode": {
          "type": "string",
          "title": "Meeting Code",
          "description": "Type friendly unique string used to join the meeting."
        },
        "activeConference": {
          "type": "object",
          "title": "Active Conference",
          "properties": {
            "conferenceRecord": {
              "type": "string",
              "title": "Conference Record",
              "description": "Reference to 'ConferenceRecord' resource."
            }
          },
          "description": "Active conference, if it exists."
        }
      },
      "description": "Data from the action execution"
    },
    "error": {
      "type": "string",
      "title": "Error",
      "description": "Error if any occurred during the execution of the action"
    },
    "successful": {
      "type": "boolean",
      "title": "Successful",
      "description": "Whether or not the action execution was successful or not"
    }
  }
}
```
