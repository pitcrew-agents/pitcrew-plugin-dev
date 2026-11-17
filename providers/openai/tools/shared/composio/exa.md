# exa

## EXA_ANSWER
Generates a direct, citation-backed answer to a clear natural language question or topic using Exa's search, adept at both specific answers and detailed summaries for open-ended queries. Response contains an `answer` field (summary) and a `citations` field (supporting URLs). Citations may include low-credibility sources; verify authoritative references for factual use.

**Input schema:**
```json
{
  "type": "object",
  "title": "AnswerRequest",
  "required": [
    "query"
  ],
  "properties": {
    "text": {
      "type": "boolean",
      "title": "Text",
      "default": false,
      "description": "Set to `true` to include the full text content of the cited source documents in the `citations` part of the response. Defaults to `false`."
    },
    "model": {
      "enum": [
        "exa",
        "exa-pro"
      ],
      "type": "string",
      "title": "Model",
      "default": "exa",
      "examples": [
        "exa",
        "exa-pro"
      ],
      "description": "Specifies the search model to use. 'exa' uses a single, direct query. 'exa-pro' uses two expanded queries for potentially more comprehensive results. Allowed values are 'exa' or 'exa-pro'. Defaults to 'exa'."
    },
    "query": {
      "type": "string",
      "title": "Query",
      "examples": [
        "What is the latest valuation of SpaceX?"
      ],
      "minLength": 1,
      "description": "The natural language question or search query for which an answer is sought. The query should be specific enough to guide the search effectively. Include concrete entities, dates, locations, or jurisdictions to avoid ambiguous results. For time-sensitive data, include explicit time framing (e.g., 'as of 2024') since results may reflect stale information."
    },
    "stream": {
      "type": "boolean",
      "title": "Stream",
      "default": false,
      "description": "Set to `true` to receive the response as a stream of server-sent events (SSE). This is useful for displaying results incrementally. Defaults to `false`."
    }
  },
  "description": "Request model for generating an answer based on a query."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Citation": {
      "type": "object",
      "title": "Citation",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "A unique temporary identifier assigned to the cited document within this response."
        },
        "url": {
          "type": "string",
          "title": "Url",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "The direct URL of the original web page or document that serves as a source for the answer."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The full text content of the cited document. This field is populated only if the `text` parameter in the `AnswerRequest` was set to `true`. Use sparingly \u2014 `text=true` produces large payloads with higher latency and cost."
        },
        "image": {
          "type": "string",
          "title": "Image",
          "description": "A URL for an image associated with the cited document, if available."
        },
        "score": {
          "type": "number",
          "title": "Score",
          "description": "Relevance score of the result"
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the web page or document cited."
        },
        "author": {
          "type": "string",
          "title": "Author",
          "description": "The author(s) of the cited content, if this information is available."
        },
        "favicon": {
          "type": "string",
          "title": "Favicon",
          "description": "A URL for the favicon of the website hosting the cited document, if available."
        },
        "snippet": {
          "type": "string",
          "title": "Snippet",
          "description": "A short snippet from the search result"
        },
        "publishedDate": {
          "type": "string",
          "title": "Published Date",
          "description": "The publication date of the cited content, formatted as YYYY-MM-DD, if available."
        }
      },
      "description": "Model for citation information in the response, detailing a source document."
    },
    "CitedChunk": {
      "type": "object",
      "title": "CitedChunk",
      "properties": {
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The excerpt of text cited from a source."
        },
        "documentId": {
          "type": "string",
          "title": "Document Id",
          "description": "ID of the document from which the chunk is cited."
        },
        "source_url": {
          "type": "string",
          "title": "Source Url",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URL of the document from which the chunk is cited."
        }
      },
      "description": "Represents a specific chunk of text cited from a source document."
    },
    "CostDollars": {
      "type": "object",
      "title": "CostDollars",
      "required": [
        "total"
      ],
      "properties": {
        "total": {
          "type": "number",
          "title": "Total",
          "description": "Total dollar cost for the request."
        },
        "breakDown": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CostBreakdownItem",
            "required": [
              "search",
              "contents",
              "breakdown"
            ],
            "properties": {
              "search": {
                "type": "number",
                "title": "Search",
                "description": "Cost of search operations."
              },
              "contents": {
                "type": "number",
                "title": "Contents",
                "description": "Cost of content operations."
              },
              "breakdown": {
                "type": "object",
                "title": "Breakdown",
                "required": [
                  "keywordSearch",
                  "neuralSearch",
                  "contentText",
                  "contentHighlight",
                  "contentSummary"
                ],
                "properties": {
                  "contentText": {
                    "type": "number",
                    "title": "Content Text",
                    "description": "Cost of text content retrieval."
                  },
                  "neuralSearch": {
                    "type": "number",
                    "title": "Neural Search",
                    "description": "Cost of neural search operations."
                  },
                  "keywordSearch": {
                    "type": "number",
                    "title": "Keyword Search",
                    "description": "Cost of keyword search operations."
                  },
                  "contentSummary": {
                    "type": "number",
                    "title": "Content Summary",
                    "description": "Cost of summary generation."
                  },
                  "contentHighlight": {
                    "type": "number",
                    "title": "Content Highlight",
                    "description": "Cost of highlight generation."
                  }
                },
                "description": "Detailed breakdown of costs."
              }
            },
            "description": "Item in the cost breakdown, detailing search and content costs."
          },
          "title": "Break Down",
          "description": "Breakdown of costs by operation type."
        },
        "perPagePrices": {
          "type": "object",
          "title": "Per Page Prices",
          "required": [
            "contentText",
            "contentHighlight",
            "contentSummary"
          ],
          "properties": {
            "contentText": {
              "type": "number",
              "title": "Content Text",
              "description": "Standard price per page for text content."
            },
            "contentSummary": {
              "type": "number",
              "title": "Content Summary",
              "description": "Standard price per page for summaries."
            },
            "contentHighlight": {
              "type": "number",
              "title": "Content Highlight",
              "description": "Standard price per page for highlights."
            }
          },
          "description": "Standard price per page for different content operations."
        },
        "perRequestPrices": {
          "type": "object",
          "title": "Per Request Prices",
          "required": [
            "neuralSearch_1_25_results",
            "neuralSearch_26_100_results",
            "neuralSearch_100_plus_results",
            "keywordSearch_1_100_results",
            "keywordSearch_100_plus_results"
          ],
          "properties": {
            "neuralSearch_1_25_results": {
              "type": "number",
              "title": "Neural Search 1 25 Results",
              "description": "Standard price for neural search with 1-25 results."
            },
            "keywordSearch_1_100_results": {
              "type": "number",
              "title": "Keyword Search 1 100 Results",
              "description": "Standard price for keyword search with 1-100 results."
            },
            "neuralSearch_26_100_results": {
              "type": "number",
              "title": "Neural Search 26 100 Results",
              "description": "Standard price for neural search with 26-100 results."
            },
            "neuralSearch_100_plus_results": {
              "type": "number",
              "title": "Neural Search 100 Plus Results",
              "description": "Standard price for neural search with 100+ results."
            },
            "keywordSearch_100_plus_results": {
              "type": "number",
              "title": "Keyword Search 100 Plus Results",
              "description": "Standard price for keyword search with 100+ results."
            }
          },
          "description": "Standard price per request for different operations."
        }
      },
      "description": "Model for cost information in the response."
    },
    "AnswerSource": {
      "type": "object",
      "title": "AnswerSource",
      "properties": {
        "url": {
          "type": "string",
          "title": "Url",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URL of the source document."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the source, if available from Exa's /answer 'sources' field."
        },
        "documentId": {
          "type": "string",
          "title": "Document Id",
          "description": "ID of the source document if it was an uploaded document."
        }
      },
      "description": "Represents a primary source used for generating the answer."
    },
    "PerPagePrices": {
      "type": "object",
      "title": "PerPagePrices",
      "required": [
        "contentText",
        "contentHighlight",
        "contentSummary"
      ],
      "properties": {
        "contentText": {
          "type": "number",
          "title": "Content Text",
          "description": "Standard price per page for text content."
        },
        "contentSummary": {
          "type": "number",
          "title": "Content Summary",
          "description": "Standard price per page for summaries."
        },
        "contentHighlight": {
          "type": "number",
          "title": "Content Highlight",
          "description": "Standard price per page for highlights."
        }
      },
      "description": "Standard price per page for different content operations."
    },
    "AnswerResponse": {
      "type": "object",
      "title": "AnswerResponse",
      "required": [
        "citations"
      ],
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "description": "The synthesized, natural language answer to the input query, generated from the information found in the cited sources."
        },
        "sources": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "AnswerSource",
            "properties": {
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URL of the source document."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the source, if available from Exa's /answer 'sources' field."
              },
              "documentId": {
                "type": "string",
                "title": "Document Id",
                "description": "ID of the source document if it was an uploaded document."
              }
            },
            "description": "Represents a primary source used for generating the answer."
          },
          "title": "Sources",
          "description": "List of primary source identifiers (URLs/IDs) used to formulate the answer."
        },
        "answerId": {
          "type": "string",
          "title": "Answer Id",
          "description": "A unique identifier for this answer interaction, if provided by Exa."
        },
        "citations": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Citation",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "A unique temporary identifier assigned to the cited document within this response."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "The direct URL of the original web page or document that serves as a source for the answer."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The full text content of the cited document. This field is populated only if the `text` parameter in the `AnswerRequest` was set to `true`. Use sparingly \u2014 `text=true` produces large payloads with higher latency and cost."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "A URL for an image associated with the cited document, if available."
              },
              "score": {
                "type": "number",
                "title": "Score",
                "description": "Relevance score of the result"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the web page or document cited."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "The author(s) of the cited content, if this information is available."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "A URL for the favicon of the website hosting the cited document, if available."
              },
              "snippet": {
                "type": "string",
                "title": "Snippet",
                "description": "A short snippet from the search result"
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "The publication date of the cited content, formatted as YYYY-MM-DD, if available."
              }
            },
            "description": "Model for citation information in the response, detailing a source document."
          },
          "title": "Citations",
          "description": "A list of `Citation` objects, each detailing a source document that contributed to the generated answer. Provides evidence and links to original content."
        },
        "citedChunks": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CitedChunk",
            "properties": {
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The excerpt of text cited from a source."
              },
              "documentId": {
                "type": "string",
                "title": "Document Id",
                "description": "ID of the document from which the chunk is cited."
              },
              "source_url": {
                "type": "string",
                "title": "Source Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URL of the document from which the chunk is cited."
              }
            },
            "description": "Represents a specific chunk of text cited from a source document."
          },
          "title": "Cited Chunks",
          "description": "Specific text excerpts cited from sources supporting the answer."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "required": [
            "total"
          ],
          "properties": {
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total dollar cost for the request."
            },
            "breakDown": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "CostBreakdownItem",
                "required": [
                  "search",
                  "contents",
                  "breakdown"
                ],
                "properties": {
                  "search": {
                    "type": "number",
                    "title": "Search",
                    "description": "Cost of search operations."
                  },
                  "contents": {
                    "type": "number",
                    "title": "Contents",
                    "description": "Cost of content operations."
                  },
                  "breakdown": {
                    "type": "object",
                    "title": "Breakdown",
                    "required": [
                      "keywordSearch",
                      "neuralSearch",
                      "contentText",
                      "contentHighlight",
                      "contentSummary"
                    ],
                    "properties": {
                      "contentText": {
                        "type": "number",
                        "title": "Content Text",
                        "description": "Cost of text content retrieval."
                      },
                      "neuralSearch": {
                        "type": "number",
                        "title": "Neural Search",
                        "description": "Cost of neural search operations."
                      },
                      "keywordSearch": {
                        "type": "number",
                        "title": "Keyword Search",
                        "description": "Cost of keyword search operations."
                      },
                      "contentSummary": {
                        "type": "number",
                        "title": "Content Summary",
                        "description": "Cost of summary generation."
                      },
                      "contentHighlight": {
                        "type": "number",
                        "title": "Content Highlight",
                        "description": "Cost of highlight generation."
                      }
                    },
                    "description": "Detailed breakdown of costs."
                  }
                },
                "description": "Item in the cost breakdown, detailing search and content costs."
              },
              "title": "Break Down",
              "description": "Breakdown of costs by operation type."
            },
            "perPagePrices": {
              "type": "object",
              "title": "Per Page Prices",
              "required": [
                "contentText",
                "contentHighlight",
                "contentSummary"
              ],
              "properties": {
                "contentText": {
                  "type": "number",
                  "title": "Content Text",
                  "description": "Standard price per page for text content."
                },
                "contentSummary": {
                  "type": "number",
                  "title": "Content Summary",
                  "description": "Standard price per page for summaries."
                },
                "contentHighlight": {
                  "type": "number",
                  "title": "Content Highlight",
                  "description": "Standard price per page for highlights."
                }
              },
              "description": "Standard price per page for different content operations."
            },
            "perRequestPrices": {
              "type": "object",
              "title": "Per Request Prices",
              "required": [
                "neuralSearch_1_25_results",
                "neuralSearch_26_100_results",
                "neuralSearch_100_plus_results",
                "keywordSearch_1_100_results",
                "keywordSearch_100_plus_results"
              ],
              "properties": {
                "neuralSearch_1_25_results": {
                  "type": "number",
                  "title": "Neural Search 1 25 Results",
                  "description": "Standard price for neural search with 1-25 results."
                },
                "keywordSearch_1_100_results": {
                  "type": "number",
                  "title": "Keyword Search 1 100 Results",
                  "description": "Standard price for keyword search with 1-100 results."
                },
                "neuralSearch_26_100_results": {
                  "type": "number",
                  "title": "Neural Search 26 100 Results",
                  "description": "Standard price for neural search with 26-100 results."
                },
                "neuralSearch_100_plus_results": {
                  "type": "number",
                  "title": "Neural Search 100 Plus Results",
                  "description": "Standard price for neural search with 100+ results."
                },
                "keywordSearch_100_plus_results": {
                  "type": "number",
                  "title": "Keyword Search 100 Plus Results",
                  "description": "Standard price for keyword search with 100+ results."
                }
              },
              "description": "Standard price per request for different operations."
            }
          },
          "description": "Cost information for the request"
        },
        "followupQuestions": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Followup Questions",
          "description": "Suggested follow-up questions related to the query."
        }
      },
      "description": "Response model containing the generated answer and its citations."
    },
    "PerRequestPrices": {
      "type": "object",
      "title": "PerRequestPrices",
      "required": [
        "neuralSearch_1_25_results",
        "neuralSearch_26_100_results",
        "neuralSearch_100_plus_results",
        "keywordSearch_1_100_results",
        "keywordSearch_100_plus_results"
      ],
      "properties": {
        "neuralSearch_1_25_results": {
          "type": "number",
          "title": "Neural Search 1 25 Results",
          "description": "Standard price for neural search with 1-25 results."
        },
        "keywordSearch_1_100_results": {
          "type": "number",
          "title": "Keyword Search 1 100 Results",
          "description": "Standard price for keyword search with 1-100 results."
        },
        "neuralSearch_26_100_results": {
          "type": "number",
          "title": "Neural Search 26 100 Results",
          "description": "Standard price for neural search with 26-100 results."
        },
        "neuralSearch_100_plus_results": {
          "type": "number",
          "title": "Neural Search 100 Plus Results",
          "description": "Standard price for neural search with 100+ results."
        },
        "keywordSearch_100_plus_results": {
          "type": "number",
          "title": "Keyword Search 100 Plus Results",
          "description": "Standard price for keyword search with 100+ results."
        }
      },
      "description": "Standard price per request for different operations."
    },
    "CostBreakdownItem": {
      "type": "object",
      "title": "CostBreakdownItem",
      "required": [
        "search",
        "contents",
        "breakdown"
      ],
      "properties": {
        "search": {
          "type": "number",
          "title": "Search",
          "description": "Cost of search operations."
        },
        "contents": {
          "type": "number",
          "title": "Contents",
          "description": "Cost of content operations."
        },
        "breakdown": {
          "type": "object",
          "title": "Breakdown",
          "required": [
            "keywordSearch",
            "neuralSearch",
            "contentText",
            "contentHighlight",
            "contentSummary"
          ],
          "properties": {
            "contentText": {
              "type": "number",
              "title": "Content Text",
              "description": "Cost of text content retrieval."
            },
            "neuralSearch": {
              "type": "number",
              "title": "Neural Search",
              "description": "Cost of neural search operations."
            },
            "keywordSearch": {
              "type": "number",
              "title": "Keyword Search",
              "description": "Cost of keyword search operations."
            },
            "contentSummary": {
              "type": "number",
              "title": "Content Summary",
              "description": "Cost of summary generation."
            },
            "contentHighlight": {
              "type": "number",
              "title": "Content Highlight",
              "description": "Cost of highlight generation."
            }
          },
          "description": "Detailed breakdown of costs."
        }
      },
      "description": "Item in the cost breakdown, detailing search and content costs."
    },
    "CostBreakdownDetail": {
      "type": "object",
      "title": "CostBreakdownDetail",
      "required": [
        "keywordSearch",
        "neuralSearch",
        "contentText",
        "contentHighlight",
        "contentSummary"
      ],
      "properties": {
        "contentText": {
          "type": "number",
          "title": "Content Text",
          "description": "Cost of text content retrieval."
        },
        "neuralSearch": {
          "type": "number",
          "title": "Neural Search",
          "description": "Cost of neural search operations."
        },
        "keywordSearch": {
          "type": "number",
          "title": "Keyword Search",
          "description": "Cost of keyword search operations."
        },
        "contentSummary": {
          "type": "number",
          "title": "Content Summary",
          "description": "Cost of summary generation."
        },
        "contentHighlight": {
          "type": "number",
          "title": "Content Highlight",
          "description": "Cost of highlight generation."
        }
      },
      "description": "Detailed breakdown of costs for search and content operations."
    }
  },
  "title": "AnswerResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "citations"
      ],
      "properties": {
        "answer": {
          "type": "string",
          "title": "Answer",
          "description": "The synthesized, natural language answer to the input query, generated from the information found in the cited sources."
        },
        "sources": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "AnswerSource",
            "properties": {
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URL of the source document."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the source, if available from Exa's /answer 'sources' field."
              },
              "documentId": {
                "type": "string",
                "title": "Document Id",
                "description": "ID of the source document if it was an uploaded document."
              }
            },
            "description": "Represents a primary source used for generating the answer."
          },
          "title": "Sources",
          "description": "List of primary source identifiers (URLs/IDs) used to formulate the answer."
        },
        "answerId": {
          "type": "string",
          "title": "Answer Id",
          "description": "A unique identifier for this answer interaction, if provided by Exa."
        },
        "citations": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Citation",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "A unique temporary identifier assigned to the cited document within this response."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "The direct URL of the original web page or document that serves as a source for the answer."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The full text content of the cited document. This field is populated only if the `text` parameter in the `AnswerRequest` was set to `true`. Use sparingly \u2014 `text=true` produces large payloads with higher latency and cost."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "A URL for an image associated with the cited document, if available."
              },
              "score": {
                "type": "number",
                "title": "Score",
                "description": "Relevance score of the result"
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the web page or document cited."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "The author(s) of the cited content, if this information is available."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "A URL for the favicon of the website hosting the cited document, if available."
              },
              "snippet": {
                "type": "string",
                "title": "Snippet",
                "description": "A short snippet from the search result"
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "The publication date of the cited content, formatted as YYYY-MM-DD, if available."
              }
            },
            "description": "Model for citation information in the response, detailing a source document."
          },
          "title": "Citations",
          "description": "A list of `Citation` objects, each detailing a source document that contributed to the generated answer. Provides evidence and links to original content."
        },
        "citedChunks": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CitedChunk",
            "properties": {
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The excerpt of text cited from a source."
              },
              "documentId": {
                "type": "string",
                "title": "Document Id",
                "description": "ID of the document from which the chunk is cited."
              },
              "source_url": {
                "type": "string",
                "title": "Source Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "URL of the document from which the chunk is cited."
              }
            },
            "description": "Represents a specific chunk of text cited from a source document."
          },
          "title": "Cited Chunks",
          "description": "Specific text excerpts cited from sources supporting the answer."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "required": [
            "total"
          ],
          "properties": {
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total dollar cost for the request."
            },
            "breakDown": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "CostBreakdownItem",
                "required": [
                  "search",
                  "contents",
                  "breakdown"
                ],
                "properties": {
                  "search": {
                    "type": "number",
                    "title": "Search",
                    "description": "Cost of search operations."
                  },
                  "contents": {
                    "type": "number",
                    "title": "Contents",
                    "description": "Cost of content operations."
                  },
                  "breakdown": {
                    "type": "object",
                    "title": "Breakdown",
                    "required": [
                      "keywordSearch",
                      "neuralSearch",
                      "contentText",
                      "contentHighlight",
                      "contentSummary"
                    ],
                    "properties": {
                      "contentText": {
                        "type": "number",
                        "title": "Content Text",
                        "description": "Cost of text content retrieval."
                      },
                      "neuralSearch": {
                        "type": "number",
                        "title": "Neural Search",
                        "description": "Cost of neural search operations."
                      },
                      "keywordSearch": {
                        "type": "number",
                        "title": "Keyword Search",
                        "description": "Cost of keyword search operations."
                      },
                      "contentSummary": {
                        "type": "number",
                        "title": "Content Summary",
                        "description": "Cost of summary generation."
                      },
                      "contentHighlight": {
                        "type": "number",
                        "title": "Content Highlight",
                        "description": "Cost of highlight generation."
                      }
                    },
                    "description": "Detailed breakdown of costs."
                  }
                },
                "description": "Item in the cost breakdown, detailing search and content costs."
              },
              "title": "Break Down",
              "description": "Breakdown of costs by operation type."
            },
            "perPagePrices": {
              "type": "object",
              "title": "Per Page Prices",
              "required": [
                "contentText",
                "contentHighlight",
                "contentSummary"
              ],
              "properties": {
                "contentText": {
                  "type": "number",
                  "title": "Content Text",
                  "description": "Standard price per page for text content."
                },
                "contentSummary": {
                  "type": "number",
                  "title": "Content Summary",
                  "description": "Standard price per page for summaries."
                },
                "contentHighlight": {
                  "type": "number",
                  "title": "Content Highlight",
                  "description": "Standard price per page for highlights."
                }
              },
              "description": "Standard price per page for different content operations."
            },
            "perRequestPrices": {
              "type": "object",
              "title": "Per Request Prices",
              "required": [
                "neuralSearch_1_25_results",
                "neuralSearch_26_100_results",
                "neuralSearch_100_plus_results",
                "keywordSearch_1_100_results",
                "keywordSearch_100_plus_results"
              ],
              "properties": {
                "neuralSearch_1_25_results": {
                  "type": "number",
                  "title": "Neural Search 1 25 Results",
                  "description": "Standard price for neural search with 1-25 results."
                },
                "keywordSearch_1_100_results": {
                  "type": "number",
                  "title": "Keyword Search 1 100 Results",
                  "description": "Standard price for keyword search with 1-100 results."
                },
                "neuralSearch_26_100_results": {
                  "type": "number",
                  "title": "Neural Search 26 100 Results",
                  "description": "Standard price for neural search with 26-100 results."
                },
                "neuralSearch_100_plus_results": {
                  "type": "number",
                  "title": "Neural Search 100 Plus Results",
                  "description": "Standard price for neural search with 100+ results."
                },
                "keywordSearch_100_plus_results": {
                  "type": "number",
                  "title": "Keyword Search 100 Plus Results",
                  "description": "Standard price for keyword search with 100+ results."
                }
              },
              "description": "Standard price per request for different operations."
            }
          },
          "description": "Cost information for the request"
        },
        "followupQuestions": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Followup Questions",
          "description": "Suggested follow-up questions related to the query."
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

## EXA_CREATE_IMPORT
Tool to create a new import to upload data into a Webset. Use when you need to initialize an import before uploading the data file.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateImportRequest",
  "required": [
    "format",
    "entity"
  ],
  "properties": {
    "csv": {
      "type": "object",
      "title": "CsvImportSettings",
      "properties": {
        "identifier": {
          "type": "integer",
          "title": "Identifier",
          "examples": [
            1
          ],
          "description": "Identifier for the CSV import."
        }
      },
      "description": "CSV-specific settings for the import.",
      "additionalProperties": false
    },
    "size": {
      "type": "integer",
      "title": "Size",
      "minimum": 0,
      "examples": [
        1024
      ],
      "description": "Size of the import in bytes."
    },
    "count": {
      "type": "integer",
      "title": "Count",
      "minimum": 0,
      "examples": [
        100
      ],
      "description": "Number of items in the import."
    },
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "My Import"
      ],
      "description": "Title of the import."
    },
    "entity": {
      "type": "object",
      "title": "Entity",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "examples": [
            "company"
          ],
          "description": "Type of entity for the import (e.g., 'company')."
        }
      },
      "description": "Entity information for the import.",
      "additionalProperties": false
    },
    "format": {
      "type": "string",
      "title": "Format",
      "examples": [
        "csv"
      ],
      "description": "Format of the import file (e.g., 'csv')."
    },
    "metadata": {
      "type": "object",
      "title": "Metadata",
      "examples": [
        {
          "key": "value"
        }
      ],
      "description": "Additional metadata for the import.",
      "additionalProperties": true
    }
  },
  "description": "Parameters to create a new import for data ingestion into a Webset."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ImportEntity": {
      "type": "object",
      "title": "ImportEntity",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "examples": [
            "company"
          ],
          "description": "Type of entity for the import (e.g., 'company')."
        }
      },
      "description": "Entity details for the import."
    },
    "CreateImportResponse": {
      "type": "object",
      "title": "CreateImportResponse",
      "required": [
        "id",
        "object",
        "status",
        "format",
        "entity",
        "createdAt",
        "updatedAt",
        "uploadUrl",
        "uploadValidUntil"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of items in the import."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "examples": [
                "company"
              ],
              "description": "Type of entity for the import (e.g., 'company')."
            }
          },
          "description": "Entity information for the import."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "Format of the import file."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Type of object (e.g., 'import')."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the import (e.g., 'pending')."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the import failed, if applicable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Additional metadata for the import.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the import was last updated."
        },
        "uploadUrl": {
          "type": "string",
          "title": "Upload Url",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URL to upload the import file."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason for failure, if the import failed."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "Failure message, if applicable."
        },
        "uploadValidUntil": {
          "type": "string",
          "title": "Upload Valid Until",
          "description": "Timestamp until the upload URL is valid."
        }
      },
      "description": "Response schema for a newly created import."
    }
  },
  "title": "CreateImportResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "object",
        "status",
        "format",
        "entity",
        "createdAt",
        "updatedAt",
        "uploadUrl",
        "uploadValidUntil"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of items in the import."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "examples": [
                "company"
              ],
              "description": "Type of entity for the import (e.g., 'company')."
            }
          },
          "description": "Entity information for the import."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "Format of the import file."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Type of object (e.g., 'import')."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the import (e.g., 'pending')."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the import failed, if applicable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Additional metadata for the import.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the import was last updated."
        },
        "uploadUrl": {
          "type": "string",
          "title": "Upload Url",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "URL to upload the import file."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason for failure, if the import failed."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "Failure message, if applicable."
        },
        "uploadValidUntil": {
          "type": "string",
          "title": "Upload Valid Until",
          "description": "Timestamp until the upload URL is valid."
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

## EXA_CREATE_MONITOR
Tool to create a new Monitor. Use when you need to schedule automated updates for a Webset without manual runs.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateMonitorRequest",
  "required": [
    "websetId",
    "cadence",
    "behavior"
  ],
  "properties": {
    "cadence": {
      "type": "object",
      "title": "Cadence",
      "required": [
        "cron"
      ],
      "properties": {
        "cron": {
          "type": "string",
          "title": "Cron",
          "examples": [
            "0 0 * * *"
          ],
          "description": "Cron expression for monitor cadence (must be a valid Unix cron with 5 fields). The schedule must trigger at most once per day."
        },
        "timezone": {
          "type": "string",
          "title": "Timezone",
          "default": "Etc/UTC",
          "description": "IANA timezone (e.g., 'America/New_York')."
        }
      },
      "description": "How often the monitor will run.",
      "additionalProperties": false
    },
    "behavior": {
      "type": "object",
      "title": "Behavior",
      "required": [
        "config"
      ],
      "properties": {
        "type": {
          "type": "string",
          "const": "search",
          "title": "Type",
          "default": "search",
          "description": "Type of behavior to execute when monitor runs."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "properties": {
            "count": {
              "type": "integer",
              "title": "Count",
              "minimum": 0,
              "description": "Number of results to return."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "examples": [
                "startup funding"
              ],
              "description": "The search query string to use for the monitor run."
            },
            "entity": {
              "type": "object",
              "title": "Entity",
              "required": [
                "type"
              ],
              "properties": {
                "type": {
                  "type": "string",
                  "title": "Type",
                  "examples": [
                    "company"
                  ],
                  "description": "Type of entity to search for (e.g., 'company')."
                }
              },
              "description": "Entity filter for the search run.",
              "additionalProperties": false
            },
            "behavior": {
              "type": "string",
              "title": "Behavior",
              "examples": [
                "append"
              ],
              "description": "Behavior to apply to results (e.g., 'append', 'replace')."
            },
            "criteria": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "BehaviorConfigCriteriaItem",
                "required": [
                  "description"
                ],
                "properties": {
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "examples": [
                      "Find new entries"
                    ],
                    "description": "A condition or filter description for the monitor's behavior configuration."
                  }
                }
              },
              "title": "Criteria",
              "description": "List of criteria objects defining additional conditions for the search run."
            }
          },
          "description": "Configuration for the behavior execution.",
          "additionalProperties": false
        }
      },
      "description": "Behavior to perform when monitor runs.",
      "additionalProperties": false
    },
    "metadata": {
      "type": "object",
      "title": "Metadata",
      "description": "Key-value pairs to associate with the Monitor.",
      "additionalProperties": {
        "type": "string"
      }
    },
    "websetId": {
      "type": "string",
      "title": "Webset Id",
      "examples": [
        "<string>"
      ],
      "description": "The ID of the Webset to attach this Monitor to."
    }
  },
  "description": "Parameters to create a new Monitor for automated Webset updates."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "MonitorEntity": {
      "type": "object",
      "title": "MonitorEntity",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Entity type used in the monitor."
        }
      }
    },
    "MonitorLastRun": {
      "type": "object",
      "title": "MonitorLastRun",
      "required": [
        "id",
        "object",
        "status",
        "monitorId",
        "type",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the Monitor Run."
        },
        "type": {
          "enum": [
            "search",
            "refresh"
          ],
          "type": "string",
          "title": "Type",
          "description": "The run type."
        },
        "object": {
          "type": "string",
          "const": "monitor_run",
          "title": "Object",
          "description": "The type of object."
        },
        "status": {
          "enum": [
            "created",
            "running",
            "completed",
            "canceled",
            "failed"
          ],
          "type": "string",
          "title": "Status",
          "description": "The status of the Monitor Run."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the run failed."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the run was created."
        },
        "monitorId": {
          "type": "string",
          "title": "Monitor Id",
          "description": "ID of the Monitor associated with this run."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the run was last updated."
        },
        "canceledAt": {
          "type": "string",
          "title": "Canceled At",
          "description": "Timestamp when the run was canceled."
        },
        "completedAt": {
          "type": "string",
          "title": "Completed At",
          "description": "Timestamp when the run completed."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason the run failed."
        }
      }
    },
    "MonitorBehavior": {
      "type": "object",
      "title": "MonitorBehavior",
      "required": [
        "type",
        "config"
      ],
      "properties": {
        "type": {
          "type": "string",
          "const": "search",
          "title": "Type",
          "description": "Type of behavior."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "required": [
            "query",
            "criteria",
            "entity",
            "count",
            "behavior"
          ],
          "properties": {
            "count": {
              "type": "integer",
              "title": "Count",
              "description": "Number of results returned per run."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "description": "Search query used by the monitor."
            },
            "entity": {
              "type": "object",
              "title": "Entity",
              "required": [
                "type"
              ],
              "properties": {
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "Entity type used in the monitor."
                }
              },
              "description": "Entity filter in the monitor run."
            },
            "behavior": {
              "type": "string",
              "title": "Behavior",
              "description": "Behavior applied to results (e.g., 'append')."
            },
            "criteria": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "MonitorBehaviorConfigCriteriaItem",
                "required": [
                  "description"
                ],
                "properties": {
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Criteria description for the monitor."
                  }
                }
              },
              "title": "Criteria",
              "description": "List of criteria applied during the monitor run."
            }
          },
          "description": "Behavior configuration."
        }
      }
    },
    "ResponseCadence": {
      "type": "object",
      "title": "ResponseCadence",
      "required": [
        "cron",
        "timezone"
      ],
      "properties": {
        "cron": {
          "type": "string",
          "title": "Cron",
          "description": "Cron expression for monitor cadence."
        },
        "timezone": {
          "type": "string",
          "title": "Timezone",
          "description": "IANA timezone for the schedule."
        }
      }
    },
    "CreateMonitorResponse": {
      "type": "object",
      "title": "CreateMonitorResponse",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "cadence",
        "behavior",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the Monitor."
        },
        "object": {
          "type": "string",
          "const": "monitor",
          "title": "Object",
          "description": "The type of object."
        },
        "status": {
          "enum": [
            "enabled",
            "disabled"
          ],
          "type": "string",
          "title": "Status",
          "description": "The status of the Monitor."
        },
        "cadence": {
          "type": "object",
          "title": "Cadence",
          "required": [
            "cron",
            "timezone"
          ],
          "properties": {
            "cron": {
              "type": "string",
              "title": "Cron",
              "description": "Cron expression for monitor cadence."
            },
            "timezone": {
              "type": "string",
              "title": "Timezone",
              "description": "IANA timezone for the schedule."
            }
          },
          "description": "Schedule configuration of the Monitor."
        },
        "lastRun": {
          "type": "object",
          "title": "Last Run",
          "required": [
            "id",
            "object",
            "status",
            "monitorId",
            "type",
            "createdAt",
            "updatedAt"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The unique identifier for the Monitor Run."
            },
            "type": {
              "enum": [
                "search",
                "refresh"
              ],
              "type": "string",
              "title": "Type",
              "description": "The run type."
            },
            "object": {
              "type": "string",
              "const": "monitor_run",
              "title": "Object",
              "description": "The type of object."
            },
            "status": {
              "enum": [
                "created",
                "running",
                "completed",
                "canceled",
                "failed"
              ],
              "type": "string",
              "title": "Status",
              "description": "The status of the Monitor Run."
            },
            "failedAt": {
              "type": "string",
              "title": "Failed At",
              "description": "Timestamp when the run failed."
            },
            "createdAt": {
              "type": "string",
              "title": "Created At",
              "description": "Timestamp when the run was created."
            },
            "monitorId": {
              "type": "string",
              "title": "Monitor Id",
              "description": "ID of the Monitor associated with this run."
            },
            "updatedAt": {
              "type": "string",
              "title": "Updated At",
              "description": "Timestamp when the run was last updated."
            },
            "canceledAt": {
              "type": "string",
              "title": "Canceled At",
              "description": "Timestamp when the run was canceled."
            },
            "completedAt": {
              "type": "string",
              "title": "Completed At",
              "description": "Timestamp when the run completed."
            },
            "failedReason": {
              "type": "string",
              "title": "Failed Reason",
              "description": "Reason the run failed."
            }
          },
          "description": "The last execution details of the Monitor."
        },
        "behavior": {
          "type": "object",
          "title": "Behavior",
          "required": [
            "type",
            "config"
          ],
          "properties": {
            "type": {
              "type": "string",
              "const": "search",
              "title": "Type",
              "description": "Type of behavior."
            },
            "config": {
              "type": "object",
              "title": "Config",
              "required": [
                "query",
                "criteria",
                "entity",
                "count",
                "behavior"
              ],
              "properties": {
                "count": {
                  "type": "integer",
                  "title": "Count",
                  "description": "Number of results returned per run."
                },
                "query": {
                  "type": "string",
                  "title": "Query",
                  "description": "Search query used by the monitor."
                },
                "entity": {
                  "type": "object",
                  "title": "Entity",
                  "required": [
                    "type"
                  ],
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Entity type used in the monitor."
                    }
                  },
                  "description": "Entity filter in the monitor run."
                },
                "behavior": {
                  "type": "string",
                  "title": "Behavior",
                  "description": "Behavior applied to results (e.g., 'append')."
                },
                "criteria": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "title": "MonitorBehaviorConfigCriteriaItem",
                    "required": [
                      "description"
                    ],
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Criteria description for the monitor."
                      }
                    }
                  },
                  "title": "Criteria",
                  "description": "List of criteria applied during the monitor run."
                }
              },
              "description": "Behavior configuration."
            }
          },
          "description": "Behavior settings of the Monitor."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Associated metadata key-value pairs.",
          "additionalProperties": {
            "type": "string"
          }
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "The id of the Webset the Monitor belongs to."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the Monitor was created."
        },
        "nextRunAt": {
          "type": "string",
          "title": "Next Run At",
          "description": "Timestamp for the next scheduled run."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the Monitor was last updated."
        }
      },
      "description": "Response model for a newly created Monitor."
    },
    "MonitorBehaviorConfig": {
      "type": "object",
      "title": "MonitorBehaviorConfig",
      "required": [
        "query",
        "criteria",
        "entity",
        "count",
        "behavior"
      ],
      "properties": {
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of results returned per run."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "description": "Search query used by the monitor."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Entity type used in the monitor."
            }
          },
          "description": "Entity filter in the monitor run."
        },
        "behavior": {
          "type": "string",
          "title": "Behavior",
          "description": "Behavior applied to results (e.g., 'append')."
        },
        "criteria": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MonitorBehaviorConfigCriteriaItem",
            "required": [
              "description"
            ],
            "properties": {
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Criteria description for the monitor."
              }
            }
          },
          "title": "Criteria",
          "description": "List of criteria applied during the monitor run."
        }
      }
    },
    "MonitorBehaviorConfigCriteriaItem": {
      "type": "object",
      "title": "MonitorBehaviorConfigCriteriaItem",
      "required": [
        "description"
      ],
      "properties": {
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Criteria description for the monitor."
        }
      }
    }
  },
  "title": "CreateMonitorResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "cadence",
        "behavior",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the Monitor."
        },
        "object": {
          "type": "string",
          "const": "monitor",
          "title": "Object",
          "description": "The type of object."
        },
        "status": {
          "enum": [
            "enabled",
            "disabled"
          ],
          "type": "string",
          "title": "Status",
          "description": "The status of the Monitor."
        },
        "cadence": {
          "type": "object",
          "title": "Cadence",
          "required": [
            "cron",
            "timezone"
          ],
          "properties": {
            "cron": {
              "type": "string",
              "title": "Cron",
              "description": "Cron expression for monitor cadence."
            },
            "timezone": {
              "type": "string",
              "title": "Timezone",
              "description": "IANA timezone for the schedule."
            }
          },
          "description": "Schedule configuration of the Monitor."
        },
        "lastRun": {
          "type": "object",
          "title": "Last Run",
          "required": [
            "id",
            "object",
            "status",
            "monitorId",
            "type",
            "createdAt",
            "updatedAt"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The unique identifier for the Monitor Run."
            },
            "type": {
              "enum": [
                "search",
                "refresh"
              ],
              "type": "string",
              "title": "Type",
              "description": "The run type."
            },
            "object": {
              "type": "string",
              "const": "monitor_run",
              "title": "Object",
              "description": "The type of object."
            },
            "status": {
              "enum": [
                "created",
                "running",
                "completed",
                "canceled",
                "failed"
              ],
              "type": "string",
              "title": "Status",
              "description": "The status of the Monitor Run."
            },
            "failedAt": {
              "type": "string",
              "title": "Failed At",
              "description": "Timestamp when the run failed."
            },
            "createdAt": {
              "type": "string",
              "title": "Created At",
              "description": "Timestamp when the run was created."
            },
            "monitorId": {
              "type": "string",
              "title": "Monitor Id",
              "description": "ID of the Monitor associated with this run."
            },
            "updatedAt": {
              "type": "string",
              "title": "Updated At",
              "description": "Timestamp when the run was last updated."
            },
            "canceledAt": {
              "type": "string",
              "title": "Canceled At",
              "description": "Timestamp when the run was canceled."
            },
            "completedAt": {
              "type": "string",
              "title": "Completed At",
              "description": "Timestamp when the run completed."
            },
            "failedReason": {
              "type": "string",
              "title": "Failed Reason",
              "description": "Reason the run failed."
            }
          },
          "description": "The last execution details of the Monitor."
        },
        "behavior": {
          "type": "object",
          "title": "Behavior",
          "required": [
            "type",
            "config"
          ],
          "properties": {
            "type": {
              "type": "string",
              "const": "search",
              "title": "Type",
              "description": "Type of behavior."
            },
            "config": {
              "type": "object",
              "title": "Config",
              "required": [
                "query",
                "criteria",
                "entity",
                "count",
                "behavior"
              ],
              "properties": {
                "count": {
                  "type": "integer",
                  "title": "Count",
                  "description": "Number of results returned per run."
                },
                "query": {
                  "type": "string",
                  "title": "Query",
                  "description": "Search query used by the monitor."
                },
                "entity": {
                  "type": "object",
                  "title": "Entity",
                  "required": [
                    "type"
                  ],
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Entity type used in the monitor."
                    }
                  },
                  "description": "Entity filter in the monitor run."
                },
                "behavior": {
                  "type": "string",
                  "title": "Behavior",
                  "description": "Behavior applied to results (e.g., 'append')."
                },
                "criteria": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "title": "MonitorBehaviorConfigCriteriaItem",
                    "required": [
                      "description"
                    ],
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Criteria description for the monitor."
                      }
                    }
                  },
                  "title": "Criteria",
                  "description": "List of criteria applied during the monitor run."
                }
              },
              "description": "Behavior configuration."
            }
          },
          "description": "Behavior settings of the Monitor."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Associated metadata key-value pairs.",
          "additionalProperties": {
            "type": "string"
          }
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "The id of the Webset the Monitor belongs to."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the Monitor was created."
        },
        "nextRunAt": {
          "type": "string",
          "title": "Next Run At",
          "description": "Timestamp for the next scheduled run."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the Monitor was last updated."
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

## EXA_CREATE_RESEARCH
Creates an asynchronous research task that explores the web, gathers sources, synthesizes findings, and returns results with citations. The API responds immediately with a researchId for polling completion status. Use this when you need to generate: 1. Structured JSON matching an outputSchema you provide 2. A detailed markdown report when no schema is provided After creation, poll the research task status using the researchId to retrieve the final results when completed.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateResearchRequest",
  "required": [
    "instructions"
  ],
  "properties": {
    "model": {
      "enum": [
        "exa-research",
        "exa-research-pro"
      ],
      "type": "string",
      "title": "ResearchModel",
      "default": "exa-research",
      "description": "Research models available for Exa research tasks."
    },
    "instructions": {
      "type": "string",
      "title": "Instructions",
      "examples": [
        "Research the latest developments in quantum computing in 2024",
        "Analyze the competitive landscape of AI coding assistants"
      ],
      "maxLength": 4096,
      "description": "Instructions for what research should be conducted. This is the natural language prompt describing the research question or topic to explore."
    },
    "outputSchema": {
      "type": "object",
      "title": "Output Schema",
      "description": "Optional JSON schema to structure the research output. If provided, the API will return structured JSON matching this schema. If omitted, the API returns a detailed markdown report.",
      "additionalProperties": true
    }
  },
  "description": "Parameters for creating an asynchronous research task."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CostDollars": {
      "type": "object",
      "title": "CostDollars",
      "properties": {
        "total": {
          "type": "number",
          "title": "Total",
          "description": "Total cost in USD"
        },
        "search": {
          "type": "number",
          "title": "Search",
          "description": "Search cost in USD"
        },
        "content": {
          "type": "number",
          "title": "Content",
          "description": "Content retrieval cost in USD"
        }
      },
      "description": "Cost information for the research task.",
      "additionalProperties": true
    },
    "ResearchEvent": {
      "type": "object",
      "title": "ResearchEvent",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of event"
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Event message or description"
        },
        "timestamp": {
          "type": "number",
          "title": "Timestamp",
          "description": "Unix timestamp when the event occurred"
        }
      },
      "description": "Event tracking progress of a research task.",
      "additionalProperties": true
    },
    "ResearchOutput": {
      "type": "object",
      "title": "ResearchOutput",
      "properties": {
        "content": {
          "type": "string",
          "title": "Content",
          "description": "Main research content or findings"
        },
        "citations": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Citations",
          "description": "List of source citations"
        }
      },
      "description": "Research output containing findings and citations.",
      "additionalProperties": true
    },
    "CreateResearchResponse": {
      "type": "object",
      "title": "CreateResearchResponse",
      "required": [
        "researchId",
        "createdAt",
        "instructions",
        "status"
      ],
      "properties": {
        "error": {
          "type": "string",
          "title": "Error",
          "description": "Error message if the research task failed (only present when status is 'failed')."
        },
        "model": {
          "type": "string",
          "title": "Model",
          "description": "The research model used for this task."
        },
        "events": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResearchEvent",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of event"
              },
              "message": {
                "type": "string",
                "title": "Message",
                "description": "Event message or description"
              },
              "timestamp": {
                "type": "number",
                "title": "Timestamp",
                "description": "Unix timestamp when the event occurred"
              }
            },
            "description": "Event tracking progress of a research task.",
            "additionalProperties": true
          },
          "title": "Events",
          "description": "List of events tracking the progress of the research task (if available)."
        },
        "output": {
          "type": "object",
          "title": "Output",
          "properties": {
            "content": {
              "type": "string",
              "title": "Content",
              "description": "Main research content or findings"
            },
            "citations": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Citations",
              "description": "List of source citations"
            }
          },
          "description": "Research output containing the findings and citations (only present when status is 'completed').",
          "additionalProperties": true
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the research task (e.g., 'pending', 'running', 'completed', 'failed')."
        },
        "createdAt": {
          "type": "number",
          "title": "Created At",
          "description": "Unix timestamp (in milliseconds) when the research task was created."
        },
        "researchId": {
          "type": "string",
          "title": "Research Id",
          "description": "Unique identifier for the research task. Use this ID to poll for completion status and retrieve results."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "properties": {
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total cost in USD"
            },
            "search": {
              "type": "number",
              "title": "Search",
              "description": "Search cost in USD"
            },
            "content": {
              "type": "number",
              "title": "Content",
              "description": "Content retrieval cost in USD"
            }
          },
          "description": "Cost information for the completed research task (only present when status is 'completed').",
          "additionalProperties": true
        },
        "instructions": {
          "type": "string",
          "title": "Instructions",
          "description": "The instructions provided for this research task."
        },
        "outputSchema": {
          "type": "object",
          "title": "Output Schema",
          "description": "The output schema that was provided in the request (echoed back).",
          "additionalProperties": true
        }
      },
      "description": "Response schema for a newly created research task."
    }
  },
  "title": "CreateResearchResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "researchId",
        "createdAt",
        "instructions",
        "status"
      ],
      "properties": {
        "error": {
          "type": "string",
          "title": "Error",
          "description": "Error message if the research task failed (only present when status is 'failed')."
        },
        "model": {
          "type": "string",
          "title": "Model",
          "description": "The research model used for this task."
        },
        "events": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResearchEvent",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of event"
              },
              "message": {
                "type": "string",
                "title": "Message",
                "description": "Event message or description"
              },
              "timestamp": {
                "type": "number",
                "title": "Timestamp",
                "description": "Unix timestamp when the event occurred"
              }
            },
            "description": "Event tracking progress of a research task.",
            "additionalProperties": true
          },
          "title": "Events",
          "description": "List of events tracking the progress of the research task (if available)."
        },
        "output": {
          "type": "object",
          "title": "Output",
          "properties": {
            "content": {
              "type": "string",
              "title": "Content",
              "description": "Main research content or findings"
            },
            "citations": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Citations",
              "description": "List of source citations"
            }
          },
          "description": "Research output containing the findings and citations (only present when status is 'completed').",
          "additionalProperties": true
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the research task (e.g., 'pending', 'running', 'completed', 'failed')."
        },
        "createdAt": {
          "type": "number",
          "title": "Created At",
          "description": "Unix timestamp (in milliseconds) when the research task was created."
        },
        "researchId": {
          "type": "string",
          "title": "Research Id",
          "description": "Unique identifier for the research task. Use this ID to poll for completion status and retrieve results."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "properties": {
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total cost in USD"
            },
            "search": {
              "type": "number",
              "title": "Search",
              "description": "Search cost in USD"
            },
            "content": {
              "type": "number",
              "title": "Content",
              "description": "Content retrieval cost in USD"
            }
          },
          "description": "Cost information for the completed research task (only present when status is 'completed').",
          "additionalProperties": true
        },
        "instructions": {
          "type": "string",
          "title": "Instructions",
          "description": "The instructions provided for this research task."
        },
        "outputSchema": {
          "type": "object",
          "title": "Output Schema",
          "description": "The output schema that was provided in the request (echoed back).",
          "additionalProperties": true
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

## EXA_CREATE_WEBSET
Tool to create a new Webset with search, import, and enrichment setup. Use when you need to configure and seed a Webset in one call.

**Input schema:**
```json
{
  "type": "object",
  "title": "CreateWebsetRequest",
  "required": [
    "search"
  ],
  "properties": {
    "import": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "WebsetImport",
        "required": [
          "source",
          "id"
        ],
        "properties": {
          "id": {
            "type": "string",
            "title": "Id",
            "description": "Identifier of the import or webset to include."
          },
          "source": {
            "enum": [
              "import",
              "webset"
            ],
            "type": "string",
            "title": "Source",
            "description": "The type of source to import ('import' or 'webset')."
          }
        },
        "description": "Import existing data into the Webset."
      },
      "title": "Import",
      "description": "Import data from existing Websets or Imports."
    },
    "search": {
      "type": "object",
      "title": "Search",
      "required": [
        "query"
      ],
      "properties": {
        "count": {
          "type": "integer",
          "title": "Count",
          "default": 10,
          "minimum": 1,
          "description": "Number of items the Webset will attempt to find."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "examples": [
            "Marketing agencies based in the US, that focus on consumer products."
          ],
          "maxLength": 5000,
          "minLength": 1,
          "description": "Natural language search query describing what you are looking for."
        },
        "scope": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SourceItem",
            "required": [
              "source",
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Identifier of the source to include or exclude."
              },
              "source": {
                "enum": [
                  "import",
                  "webset"
                ],
                "type": "string",
                "title": "Source",
                "description": "The type of source ('import' or 'webset')."
              }
            },
            "description": "Source to include or exclude in search."
          },
          "title": "Scope",
          "description": "Limit the search to specific sources."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "properties": {
            "type": {
              "enum": [
                "company",
                "person",
                "article",
                "research_paper",
                "custom"
              ],
              "type": "string",
              "title": "Type",
              "default": "company",
              "description": "Allowed entity types for the search or import."
            }
          },
          "description": "Entity type for searches and imports.",
          "additionalProperties": false
        },
        "recall": {
          "type": "boolean",
          "title": "Recall",
          "description": "Whether to estimate total relevant results available for this search."
        },
        "exclude": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SourceItem",
            "required": [
              "source",
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Identifier of the source to include or exclude."
              },
              "source": {
                "enum": [
                  "import",
                  "webset"
                ],
                "type": "string",
                "title": "Source",
                "description": "The type of source ('import' or 'webset')."
              }
            },
            "description": "Source to include or exclude in search."
          },
          "title": "Exclude",
          "description": "Sources to exclude from search results."
        },
        "criteria": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Criterion",
            "required": [
              "description"
            ],
            "properties": {
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the evaluation criterion."
              },
              "successRate": {
                "type": "integer",
                "title": "Success Rate",
                "description": "Success rate percentage for this criterion."
              }
            },
            "description": "Criterion to evaluate search results against."
          },
          "title": "Criteria",
          "description": "Custom criteria to evaluate items against."
        }
      },
      "description": "Initial search configuration for the Webset.",
      "additionalProperties": false
    },
    "metadata": {
      "type": "object",
      "title": "Metadata",
      "description": "Arbitrary key-value pairs to associate with this Webset.",
      "additionalProperties": true
    },
    "externalId": {
      "type": "string",
      "title": "External Id",
      "maxLength": 300,
      "description": "External identifier to reference the Webset in your system."
    },
    "enrichments": {
      "type": "array",
      "items": {
        "type": "object",
        "title": "CreateEnrichmentParameters",
        "required": [
          "title"
        ],
        "properties": {
          "title": {
            "type": "string",
            "title": "Title",
            "description": "Title of the enrichment task."
          },
          "format": {
            "type": "string",
            "const": "text",
            "title": "Format",
            "description": "Format of the enrichment output, e.g., 'text'."
          },
          "options": {
            "type": "array",
            "items": {
              "type": "object",
              "additionalProperties": true
            },
            "title": "Options",
            "description": "Additional options for enrichment."
          },
          "description": {
            "type": "string",
            "title": "Description",
            "description": "Description of what to enrich for."
          },
          "instructions": {
            "type": "string",
            "title": "Instructions",
            "description": "Instructions for the enrichment process."
          }
        },
        "description": "Parameters to create an enrichment."
      },
      "title": "Enrichments",
      "description": "Enrichments to apply to Webset items."
    }
  },
  "description": "Parameters to create a new Webset with initial search, imports, and enrichments."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Bounds": {
      "type": "object",
      "title": "Bounds",
      "required": [
        "min",
        "max"
      ],
      "properties": {
        "max": {
          "type": "integer",
          "title": "Max",
          "description": "Maximum estimated count."
        },
        "min": {
          "type": "integer",
          "title": "Min",
          "description": "Minimum estimated count."
        }
      }
    },
    "Entity": {
      "type": "object",
      "title": "Entity",
      "properties": {
        "type": {
          "enum": [
            "company",
            "person",
            "article",
            "research_paper",
            "custom"
          ],
          "type": "string",
          "title": "Type",
          "default": "company",
          "description": "Allowed entity types for the search or import."
        }
      },
      "description": "Entity type for searches and imports."
    },
    "Recall": {
      "type": "object",
      "title": "Recall",
      "required": [
        "expected"
      ],
      "properties": {
        "expected": {
          "type": "object",
          "title": "Expected",
          "required": [
            "total",
            "confidence",
            "bounds"
          ],
          "properties": {
            "total": {
              "type": "integer",
              "title": "Total",
              "description": "Estimated total relevant results."
            },
            "bounds": {
              "type": "object",
              "title": "Bounds",
              "required": [
                "min",
                "max"
              ],
              "properties": {
                "max": {
                  "type": "integer",
                  "title": "Max",
                  "description": "Maximum estimated count."
                },
                "min": {
                  "type": "integer",
                  "title": "Min",
                  "description": "Minimum estimated count."
                }
              },
              "description": "Confidence bounds for the estimate."
            },
            "confidence": {
              "enum": [
                "low",
                "medium",
                "high"
              ],
              "type": "string",
              "title": "Confidence",
              "description": "Confidence level of the estimate."
            }
          },
          "description": "Expected recall metrics."
        },
        "reasoning": {
          "type": "string",
          "title": "Reasoning",
          "description": "Reasoning behind the recall estimate."
        }
      }
    },
    "Cadence": {
      "type": "object",
      "title": "Cadence",
      "required": [
        "cron",
        "timezone"
      ],
      "properties": {
        "cron": {
          "type": "string",
          "title": "Cron",
          "description": "Cron expression for scheduling."
        },
        "timezone": {
          "type": "string",
          "title": "Timezone",
          "description": "Timezone for the schedule, e.g. 'Etc/UTC'."
        }
      },
      "description": "Schedule cadence for a monitor."
    },
    "Expected": {
      "type": "object",
      "title": "Expected",
      "required": [
        "total",
        "confidence",
        "bounds"
      ],
      "properties": {
        "total": {
          "type": "integer",
          "title": "Total",
          "description": "Estimated total relevant results."
        },
        "bounds": {
          "type": "object",
          "title": "Bounds",
          "required": [
            "min",
            "max"
          ],
          "properties": {
            "max": {
              "type": "integer",
              "title": "Max",
              "description": "Maximum estimated count."
            },
            "min": {
              "type": "integer",
              "title": "Min",
              "description": "Minimum estimated count."
            }
          },
          "description": "Confidence bounds for the estimate."
        },
        "confidence": {
          "enum": [
            "low",
            "medium",
            "high"
          ],
          "type": "string",
          "title": "Confidence",
          "description": "Confidence level of the estimate."
        }
      }
    },
    "Progress": {
      "type": "object",
      "title": "Progress",
      "required": [
        "found",
        "analyzed",
        "completion",
        "timeLeft"
      ],
      "properties": {
        "found": {
          "type": "integer",
          "title": "Found",
          "description": "Number of items found so far."
        },
        "analyzed": {
          "type": "integer",
          "title": "Analyzed",
          "description": "Number of items analyzed so far."
        },
        "timeLeft": {
          "type": "integer",
          "title": "Time Left",
          "description": "Estimated time left in seconds."
        },
        "completion": {
          "type": "integer",
          "title": "Completion",
          "description": "Percent completion of the search."
        }
      }
    },
    "Criterion": {
      "type": "object",
      "title": "Criterion",
      "required": [
        "description"
      ],
      "properties": {
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the evaluation criterion."
        },
        "successRate": {
          "type": "integer",
          "title": "Success Rate",
          "description": "Success rate percentage for this criterion."
        }
      },
      "description": "Criterion to evaluate search results against."
    },
    "ImportItem": {
      "type": "object",
      "title": "ImportItem",
      "required": [
        "id",
        "object",
        "status",
        "format",
        "entity",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of items in the import."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "properties": {
            "type": {
              "enum": [
                "company",
                "person",
                "article",
                "research_paper",
                "custom"
              ],
              "type": "string",
              "title": "Type",
              "default": "company",
              "description": "Allowed entity types for the search or import."
            }
          },
          "description": "Entity type of the import."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "Format of the import."
        },
        "object": {
          "type": "string",
          "const": "import",
          "title": "Object",
          "description": "Object type, always 'import'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the import."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Failure timestamp."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Metadata for the import.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Creation timestamp of the import."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Last update timestamp of the import."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason for import failure."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "Failure message."
        }
      },
      "description": "Represents an import performed on the Webset."
    },
    "MonitorRun": {
      "type": "object",
      "title": "MonitorRun",
      "required": [
        "id",
        "object",
        "status",
        "monitorId",
        "type",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Run identifier."
        },
        "type": {
          "type": "string",
          "const": "search",
          "title": "Type",
          "description": "Type of run."
        },
        "object": {
          "type": "string",
          "const": "monitor_run",
          "title": "Object",
          "description": "Object type."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the run."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Failure timestamp."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Creation timestamp."
        },
        "monitorId": {
          "type": "string",
          "title": "Monitor Id",
          "description": "Identifier of the monitor."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Last update timestamp."
        },
        "canceledAt": {
          "type": "string",
          "title": "Canceled At",
          "description": "Cancelation timestamp."
        },
        "completedAt": {
          "type": "string",
          "title": "Completed At",
          "description": "Completion timestamp."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason for failure."
        }
      },
      "description": "Represents the last run of a monitor."
    },
    "SourceItem": {
      "type": "object",
      "title": "SourceItem",
      "required": [
        "source",
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Identifier of the source to include or exclude."
        },
        "source": {
          "enum": [
            "import",
            "webset"
          ],
          "type": "string",
          "title": "Source",
          "description": "The type of source ('import' or 'webset')."
        }
      },
      "description": "Source to include or exclude in search."
    },
    "MonitorItem": {
      "type": "object",
      "title": "MonitorItem",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "cadence",
        "behavior",
        "lastRun",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the monitor."
        },
        "object": {
          "type": "string",
          "const": "monitor",
          "title": "Object",
          "description": "Object type."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the monitor."
        },
        "cadence": {
          "type": "object",
          "title": "Cadence",
          "required": [
            "cron",
            "timezone"
          ],
          "properties": {
            "cron": {
              "type": "string",
              "title": "Cron",
              "description": "Cron expression for scheduling."
            },
            "timezone": {
              "type": "string",
              "title": "Timezone",
              "description": "Timezone for the schedule, e.g. 'Etc/UTC'."
            }
          },
          "description": "Schedule cadence of the monitor."
        },
        "lastRun": {
          "type": "object",
          "title": "Last Run",
          "required": [
            "id",
            "object",
            "status",
            "monitorId",
            "type",
            "createdAt",
            "updatedAt"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Run identifier."
            },
            "type": {
              "type": "string",
              "const": "search",
              "title": "Type",
              "description": "Type of run."
            },
            "object": {
              "type": "string",
              "const": "monitor_run",
              "title": "Object",
              "description": "Object type."
            },
            "status": {
              "type": "string",
              "title": "Status",
              "description": "Status of the run."
            },
            "failedAt": {
              "type": "string",
              "title": "Failed At",
              "description": "Failure timestamp."
            },
            "createdAt": {
              "type": "string",
              "title": "Created At",
              "description": "Creation timestamp."
            },
            "monitorId": {
              "type": "string",
              "title": "Monitor Id",
              "description": "Identifier of the monitor."
            },
            "updatedAt": {
              "type": "string",
              "title": "Updated At",
              "description": "Last update timestamp."
            },
            "canceledAt": {
              "type": "string",
              "title": "Canceled At",
              "description": "Cancelation timestamp."
            },
            "completedAt": {
              "type": "string",
              "title": "Completed At",
              "description": "Completion timestamp."
            },
            "failedReason": {
              "type": "string",
              "title": "Failed Reason",
              "description": "Reason for failure."
            }
          },
          "description": "Last run details."
        },
        "behavior": {
          "type": "object",
          "title": "Behavior",
          "required": [
            "type",
            "config"
          ],
          "properties": {
            "type": {
              "type": "string",
              "const": "search",
              "title": "Type",
              "description": "Type of monitor behavior."
            },
            "config": {
              "type": "object",
              "title": "Config",
              "required": [
                "query",
                "criteria",
                "entity",
                "count",
                "behavior"
              ],
              "properties": {
                "count": {
                  "type": "integer",
                  "title": "Count",
                  "description": "Number of items to find each run."
                },
                "query": {
                  "type": "string",
                  "title": "Query",
                  "description": "Search query for monitor runs."
                },
                "entity": {
                  "type": "object",
                  "title": "Entity",
                  "properties": {
                    "type": {
                      "enum": [
                        "company",
                        "person",
                        "article",
                        "research_paper",
                        "custom"
                      ],
                      "type": "string",
                      "title": "Type",
                      "default": "company",
                      "description": "Allowed entity types for the search or import."
                    }
                  },
                  "description": "Entity type for the monitor."
                },
                "behavior": {
                  "type": "string",
                  "title": "Behavior",
                  "description": "Behavior mode for monitor, e.g. 'append'."
                },
                "criteria": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "title": "Criterion",
                    "required": [
                      "description"
                    ],
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "Description of the evaluation criterion."
                      },
                      "successRate": {
                        "type": "integer",
                        "title": "Success Rate",
                        "description": "Success rate percentage for this criterion."
                      }
                    },
                    "description": "Criterion to evaluate search results against."
                  },
                  "title": "Criteria",
                  "description": "Criteria to evaluate monitor results."
                }
              },
              "description": "Monitor behavior configuration."
            }
          },
          "description": "Monitor behavior details."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Metadata for the monitor.",
          "additionalProperties": true
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "Identifier of the parent webset."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Creation timestamp of the monitor."
        },
        "nextRunAt": {
          "type": "string",
          "title": "Next Run At",
          "description": "Next scheduled run timestamp."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Last update timestamp of the monitor."
        }
      },
      "description": "Represents a monitor configured on the Webset."
    },
    "BehaviorConfig": {
      "type": "object",
      "title": "BehaviorConfig",
      "required": [
        "query",
        "criteria",
        "entity",
        "count",
        "behavior"
      ],
      "properties": {
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of items to find each run."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "description": "Search query for monitor runs."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "properties": {
            "type": {
              "enum": [
                "company",
                "person",
                "article",
                "research_paper",
                "custom"
              ],
              "type": "string",
              "title": "Type",
              "default": "company",
              "description": "Allowed entity types for the search or import."
            }
          },
          "description": "Entity type for the monitor."
        },
        "behavior": {
          "type": "string",
          "title": "Behavior",
          "description": "Behavior mode for monitor, e.g. 'append'."
        },
        "criteria": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Criterion",
            "required": [
              "description"
            ],
            "properties": {
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the evaluation criterion."
              },
              "successRate": {
                "type": "integer",
                "title": "Success Rate",
                "description": "Success rate percentage for this criterion."
              }
            },
            "description": "Criterion to evaluate search results against."
          },
          "title": "Criteria",
          "description": "Criteria to evaluate monitor results."
        }
      },
      "description": "Configuration for monitor behavior."
    },
    "EnrichmentItem": {
      "type": "object",
      "title": "EnrichmentItem",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "title",
        "format",
        "options",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the enrichment."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the enrichment."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "Format of enrichment output."
        },
        "object": {
          "type": "string",
          "const": "webset_enrichment",
          "title": "Object",
          "description": "Object type."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the enrichment."
        },
        "options": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "EnrichmentOption",
            "required": [
              "label"
            ],
            "properties": {
              "label": {
                "type": "string",
                "title": "Label",
                "description": "Label of the enrichment option."
              }
            },
            "description": "Option for enrichment output."
          },
          "title": "Options",
          "description": "Available options for the enrichment."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Metadata for the enrichment.",
          "additionalProperties": true
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "Identifier of the parent webset."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Creation timestamp of the enrichment."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Last update timestamp of the enrichment."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the enrichment."
        },
        "instructions": {
          "type": "string",
          "title": "Instructions",
          "description": "Instructions for the enrichment."
        }
      },
      "description": "Represents an enrichment task within the Webset."
    },
    "MonitorBehavior": {
      "type": "object",
      "title": "MonitorBehavior",
      "required": [
        "type",
        "config"
      ],
      "properties": {
        "type": {
          "type": "string",
          "const": "search",
          "title": "Type",
          "description": "Type of monitor behavior."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "required": [
            "query",
            "criteria",
            "entity",
            "count",
            "behavior"
          ],
          "properties": {
            "count": {
              "type": "integer",
              "title": "Count",
              "description": "Number of items to find each run."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "description": "Search query for monitor runs."
            },
            "entity": {
              "type": "object",
              "title": "Entity",
              "properties": {
                "type": {
                  "enum": [
                    "company",
                    "person",
                    "article",
                    "research_paper",
                    "custom"
                  ],
                  "type": "string",
                  "title": "Type",
                  "default": "company",
                  "description": "Allowed entity types for the search or import."
                }
              },
              "description": "Entity type for the monitor."
            },
            "behavior": {
              "type": "string",
              "title": "Behavior",
              "description": "Behavior mode for monitor, e.g. 'append'."
            },
            "criteria": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Criterion",
                "required": [
                  "description"
                ],
                "properties": {
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Description of the evaluation criterion."
                  },
                  "successRate": {
                    "type": "integer",
                    "title": "Success Rate",
                    "description": "Success rate percentage for this criterion."
                  }
                },
                "description": "Criterion to evaluate search results against."
              },
              "title": "Criteria",
              "description": "Criteria to evaluate monitor results."
            }
          },
          "description": "Monitor behavior configuration."
        }
      },
      "description": "Defines monitor behavior and config."
    },
    "EnrichmentOption": {
      "type": "object",
      "title": "EnrichmentOption",
      "required": [
        "label"
      ],
      "properties": {
        "label": {
          "type": "string",
          "title": "Label",
          "description": "Label of the enrichment option."
        }
      },
      "description": "Option for enrichment output."
    },
    "WebsetSearchItem": {
      "type": "object",
      "title": "WebsetSearchItem",
      "required": [
        "id",
        "object",
        "status",
        "query",
        "entity",
        "criteria",
        "count",
        "behavior",
        "exclude",
        "scope",
        "progress",
        "recall",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the search."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of items requested to find."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "description": "Search query used."
        },
        "scope": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SourceItem",
            "required": [
              "source",
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Identifier of the source to include or exclude."
              },
              "source": {
                "enum": [
                  "import",
                  "webset"
                ],
                "type": "string",
                "title": "Source",
                "description": "The type of source ('import' or 'webset')."
              }
            },
            "description": "Source to include or exclude in search."
          },
          "title": "Scope",
          "description": "Sources specifically scoped for this search."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "properties": {
            "type": {
              "enum": [
                "company",
                "person",
                "article",
                "research_paper",
                "custom"
              ],
              "type": "string",
              "title": "Type",
              "default": "company",
              "description": "Allowed entity types for the search or import."
            }
          },
          "description": "Entity type for the search."
        },
        "object": {
          "type": "string",
          "const": "webset_search",
          "title": "Object",
          "description": "Object type, always 'webset_search'."
        },
        "recall": {
          "type": "object",
          "title": "Recall",
          "required": [
            "expected"
          ],
          "properties": {
            "expected": {
              "type": "object",
              "title": "Expected",
              "required": [
                "total",
                "confidence",
                "bounds"
              ],
              "properties": {
                "total": {
                  "type": "integer",
                  "title": "Total",
                  "description": "Estimated total relevant results."
                },
                "bounds": {
                  "type": "object",
                  "title": "Bounds",
                  "required": [
                    "min",
                    "max"
                  ],
                  "properties": {
                    "max": {
                      "type": "integer",
                      "title": "Max",
                      "description": "Maximum estimated count."
                    },
                    "min": {
                      "type": "integer",
                      "title": "Min",
                      "description": "Minimum estimated count."
                    }
                  },
                  "description": "Confidence bounds for the estimate."
                },
                "confidence": {
                  "enum": [
                    "low",
                    "medium",
                    "high"
                  ],
                  "type": "string",
                  "title": "Confidence",
                  "description": "Confidence level of the estimate."
                }
              },
              "description": "Expected recall metrics."
            },
            "reasoning": {
              "type": "string",
              "title": "Reasoning",
              "description": "Reasoning behind the recall estimate."
            }
          },
          "description": "Recall metrics for the search."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the search."
        },
        "exclude": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SourceItem",
            "required": [
              "source",
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Identifier of the source to include or exclude."
              },
              "source": {
                "enum": [
                  "import",
                  "webset"
                ],
                "type": "string",
                "title": "Source",
                "description": "The type of source ('import' or 'webset')."
              }
            },
            "description": "Source to include or exclude in search."
          },
          "title": "Exclude",
          "description": "Sources excluded from this search."
        },
        "behavior": {
          "type": "string",
          "title": "Behavior",
          "description": "Behavior used for this search, e.g. 'override'."
        },
        "criteria": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Criterion",
            "required": [
              "description"
            ],
            "properties": {
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the evaluation criterion."
              },
              "successRate": {
                "type": "integer",
                "title": "Success Rate",
                "description": "Success rate percentage for this criterion."
              }
            },
            "description": "Criterion to evaluate search results against."
          },
          "title": "Criteria",
          "description": "Evaluation criteria used."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Metadata for the search.",
          "additionalProperties": true
        },
        "progress": {
          "type": "object",
          "title": "Progress",
          "required": [
            "found",
            "analyzed",
            "completion",
            "timeLeft"
          ],
          "properties": {
            "found": {
              "type": "integer",
              "title": "Found",
              "description": "Number of items found so far."
            },
            "analyzed": {
              "type": "integer",
              "title": "Analyzed",
              "description": "Number of items analyzed so far."
            },
            "timeLeft": {
              "type": "integer",
              "title": "Time Left",
              "description": "Estimated time left in seconds."
            },
            "completion": {
              "type": "integer",
              "title": "Completion",
              "description": "Percent completion of the search."
            }
          },
          "description": "Progress metrics for the search."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Creation timestamp of the search."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Last update timestamp of the search."
        },
        "canceledAt": {
          "type": "string",
          "title": "Canceled At",
          "description": "Timestamp when search was canceled."
        },
        "canceledReason": {
          "type": "string",
          "title": "Canceled Reason",
          "description": "Reason search was canceled."
        }
      },
      "description": "Represents a search performed within the Webset."
    },
    "CreateWebsetResponse": {
      "type": "object",
      "title": "CreateWebsetResponse",
      "required": [
        "id",
        "object",
        "status",
        "searches",
        "imports",
        "enrichments",
        "monitors",
        "streams",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the webset."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the webset, if set."
        },
        "object": {
          "type": "string",
          "const": "webset",
          "title": "Object",
          "description": "Object type."
        },
        "status": {
          "enum": [
            "idle",
            "pending",
            "running",
            "paused"
          ],
          "type": "string",
          "title": "Status",
          "description": "Status of the webset."
        },
        "imports": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImportItem",
            "required": [
              "id",
              "object",
              "status",
              "format",
              "entity",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the import."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Number of items in the import."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the import."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "properties": {
                  "type": {
                    "enum": [
                      "company",
                      "person",
                      "article",
                      "research_paper",
                      "custom"
                    ],
                    "type": "string",
                    "title": "Type",
                    "default": "company",
                    "description": "Allowed entity types for the search or import."
                  }
                },
                "description": "Entity type of the import."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "Format of the import."
              },
              "object": {
                "type": "string",
                "const": "import",
                "title": "Object",
                "description": "Object type, always 'import'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of the import."
              },
              "failedAt": {
                "type": "string",
                "title": "Failed At",
                "description": "Failure timestamp."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata for the import.",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp of the import."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Last update timestamp of the import."
              },
              "failedReason": {
                "type": "string",
                "title": "Failed Reason",
                "description": "Reason for import failure."
              },
              "failedMessage": {
                "type": "string",
                "title": "Failed Message",
                "description": "Failure message."
              }
            },
            "description": "Represents an import performed on the Webset."
          },
          "title": "Imports",
          "description": "Imports performed on the webset."
        },
        "streams": {
          "type": "array",
          "items": {},
          "title": "Streams",
          "description": "Streams associated with the webset."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Metadata for the webset.",
          "additionalProperties": true
        },
        "monitors": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MonitorItem",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "cadence",
              "behavior",
              "lastRun",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the monitor."
              },
              "object": {
                "type": "string",
                "const": "monitor",
                "title": "Object",
                "description": "Object type."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of the monitor."
              },
              "cadence": {
                "type": "object",
                "title": "Cadence",
                "required": [
                  "cron",
                  "timezone"
                ],
                "properties": {
                  "cron": {
                    "type": "string",
                    "title": "Cron",
                    "description": "Cron expression for scheduling."
                  },
                  "timezone": {
                    "type": "string",
                    "title": "Timezone",
                    "description": "Timezone for the schedule, e.g. 'Etc/UTC'."
                  }
                },
                "description": "Schedule cadence of the monitor."
              },
              "lastRun": {
                "type": "object",
                "title": "Last Run",
                "required": [
                  "id",
                  "object",
                  "status",
                  "monitorId",
                  "type",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Run identifier."
                  },
                  "type": {
                    "type": "string",
                    "const": "search",
                    "title": "Type",
                    "description": "Type of run."
                  },
                  "object": {
                    "type": "string",
                    "const": "monitor_run",
                    "title": "Object",
                    "description": "Object type."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Status of the run."
                  },
                  "failedAt": {
                    "type": "string",
                    "title": "Failed At",
                    "description": "Failure timestamp."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "Creation timestamp."
                  },
                  "monitorId": {
                    "type": "string",
                    "title": "Monitor Id",
                    "description": "Identifier of the monitor."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "Last update timestamp."
                  },
                  "canceledAt": {
                    "type": "string",
                    "title": "Canceled At",
                    "description": "Cancelation timestamp."
                  },
                  "completedAt": {
                    "type": "string",
                    "title": "Completed At",
                    "description": "Completion timestamp."
                  },
                  "failedReason": {
                    "type": "string",
                    "title": "Failed Reason",
                    "description": "Reason for failure."
                  }
                },
                "description": "Last run details."
              },
              "behavior": {
                "type": "object",
                "title": "Behavior",
                "required": [
                  "type",
                  "config"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "const": "search",
                    "title": "Type",
                    "description": "Type of monitor behavior."
                  },
                  "config": {
                    "type": "object",
                    "title": "Config",
                    "required": [
                      "query",
                      "criteria",
                      "entity",
                      "count",
                      "behavior"
                    ],
                    "properties": {
                      "count": {
                        "type": "integer",
                        "title": "Count",
                        "description": "Number of items to find each run."
                      },
                      "query": {
                        "type": "string",
                        "title": "Query",
                        "description": "Search query for monitor runs."
                      },
                      "entity": {
                        "type": "object",
                        "title": "Entity",
                        "properties": {
                          "type": {
                            "enum": [
                              "company",
                              "person",
                              "article",
                              "research_paper",
                              "custom"
                            ],
                            "type": "string",
                            "title": "Type",
                            "default": "company",
                            "description": "Allowed entity types for the search or import."
                          }
                        },
                        "description": "Entity type for the monitor."
                      },
                      "behavior": {
                        "type": "string",
                        "title": "Behavior",
                        "description": "Behavior mode for monitor, e.g. 'append'."
                      },
                      "criteria": {
                        "type": "array",
                        "items": {
                          "type": "object",
                          "title": "Criterion",
                          "required": [
                            "description"
                          ],
                          "properties": {
                            "description": {
                              "type": "string",
                              "title": "Description",
                              "description": "Description of the evaluation criterion."
                            },
                            "successRate": {
                              "type": "integer",
                              "title": "Success Rate",
                              "description": "Success rate percentage for this criterion."
                            }
                          },
                          "description": "Criterion to evaluate search results against."
                        },
                        "title": "Criteria",
                        "description": "Criteria to evaluate monitor results."
                      }
                    },
                    "description": "Monitor behavior configuration."
                  }
                },
                "description": "Monitor behavior details."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata for the monitor.",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "Identifier of the parent webset."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp of the monitor."
              },
              "nextRunAt": {
                "type": "string",
                "title": "Next Run At",
                "description": "Next scheduled run timestamp."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Last update timestamp of the monitor."
              }
            },
            "description": "Represents a monitor configured on the Webset."
          },
          "title": "Monitors",
          "description": "Monitors configured on the webset."
        },
        "searches": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebsetSearchItem",
            "required": [
              "id",
              "object",
              "status",
              "query",
              "entity",
              "criteria",
              "count",
              "behavior",
              "exclude",
              "scope",
              "progress",
              "recall",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the search."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Number of items requested to find."
              },
              "query": {
                "type": "string",
                "title": "Query",
                "description": "Search query used."
              },
              "scope": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "SourceItem",
                  "required": [
                    "source",
                    "id"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "Identifier of the source to include or exclude."
                    },
                    "source": {
                      "enum": [
                        "import",
                        "webset"
                      ],
                      "type": "string",
                      "title": "Source",
                      "description": "The type of source ('import' or 'webset')."
                    }
                  },
                  "description": "Source to include or exclude in search."
                },
                "title": "Scope",
                "description": "Sources specifically scoped for this search."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "properties": {
                  "type": {
                    "enum": [
                      "company",
                      "person",
                      "article",
                      "research_paper",
                      "custom"
                    ],
                    "type": "string",
                    "title": "Type",
                    "default": "company",
                    "description": "Allowed entity types for the search or import."
                  }
                },
                "description": "Entity type for the search."
              },
              "object": {
                "type": "string",
                "const": "webset_search",
                "title": "Object",
                "description": "Object type, always 'webset_search'."
              },
              "recall": {
                "type": "object",
                "title": "Recall",
                "required": [
                  "expected"
                ],
                "properties": {
                  "expected": {
                    "type": "object",
                    "title": "Expected",
                    "required": [
                      "total",
                      "confidence",
                      "bounds"
                    ],
                    "properties": {
                      "total": {
                        "type": "integer",
                        "title": "Total",
                        "description": "Estimated total relevant results."
                      },
                      "bounds": {
                        "type": "object",
                        "title": "Bounds",
                        "required": [
                          "min",
                          "max"
                        ],
                        "properties": {
                          "max": {
                            "type": "integer",
                            "title": "Max",
                            "description": "Maximum estimated count."
                          },
                          "min": {
                            "type": "integer",
                            "title": "Min",
                            "description": "Minimum estimated count."
                          }
                        },
                        "description": "Confidence bounds for the estimate."
                      },
                      "confidence": {
                        "enum": [
                          "low",
                          "medium",
                          "high"
                        ],
                        "type": "string",
                        "title": "Confidence",
                        "description": "Confidence level of the estimate."
                      }
                    },
                    "description": "Expected recall metrics."
                  },
                  "reasoning": {
                    "type": "string",
                    "title": "Reasoning",
                    "description": "Reasoning behind the recall estimate."
                  }
                },
                "description": "Recall metrics for the search."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of the search."
              },
              "exclude": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "SourceItem",
                  "required": [
                    "source",
                    "id"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "Identifier of the source to include or exclude."
                    },
                    "source": {
                      "enum": [
                        "import",
                        "webset"
                      ],
                      "type": "string",
                      "title": "Source",
                      "description": "The type of source ('import' or 'webset')."
                    }
                  },
                  "description": "Source to include or exclude in search."
                },
                "title": "Exclude",
                "description": "Sources excluded from this search."
              },
              "behavior": {
                "type": "string",
                "title": "Behavior",
                "description": "Behavior used for this search, e.g. 'override'."
              },
              "criteria": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Criterion",
                  "required": [
                    "description"
                  ],
                  "properties": {
                    "description": {
                      "type": "string",
                      "title": "Description",
                      "description": "Description of the evaluation criterion."
                    },
                    "successRate": {
                      "type": "integer",
                      "title": "Success Rate",
                      "description": "Success rate percentage for this criterion."
                    }
                  },
                  "description": "Criterion to evaluate search results against."
                },
                "title": "Criteria",
                "description": "Evaluation criteria used."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata for the search.",
                "additionalProperties": true
              },
              "progress": {
                "type": "object",
                "title": "Progress",
                "required": [
                  "found",
                  "analyzed",
                  "completion",
                  "timeLeft"
                ],
                "properties": {
                  "found": {
                    "type": "integer",
                    "title": "Found",
                    "description": "Number of items found so far."
                  },
                  "analyzed": {
                    "type": "integer",
                    "title": "Analyzed",
                    "description": "Number of items analyzed so far."
                  },
                  "timeLeft": {
                    "type": "integer",
                    "title": "Time Left",
                    "description": "Estimated time left in seconds."
                  },
                  "completion": {
                    "type": "integer",
                    "title": "Completion",
                    "description": "Percent completion of the search."
                  }
                },
                "description": "Progress metrics for the search."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp of the search."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Last update timestamp of the search."
              },
              "canceledAt": {
                "type": "string",
                "title": "Canceled At",
                "description": "Timestamp when search was canceled."
              },
              "canceledReason": {
                "type": "string",
                "title": "Canceled Reason",
                "description": "Reason search was canceled."
              }
            },
            "description": "Represents a search performed within the Webset."
          },
          "title": "Searches",
          "description": "Searches performed on the webset."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Creation timestamp of the webset."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Last update timestamp of the webset."
        },
        "externalId": {
          "type": "string",
          "title": "External Id",
          "description": "External identifier, if set."
        },
        "enrichments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "EnrichmentItem",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "title",
              "format",
              "options",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the enrichment."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the enrichment."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "Format of enrichment output."
              },
              "object": {
                "type": "string",
                "const": "webset_enrichment",
                "title": "Object",
                "description": "Object type."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of the enrichment."
              },
              "options": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "EnrichmentOption",
                  "required": [
                    "label"
                  ],
                  "properties": {
                    "label": {
                      "type": "string",
                      "title": "Label",
                      "description": "Label of the enrichment option."
                    }
                  },
                  "description": "Option for enrichment output."
                },
                "title": "Options",
                "description": "Available options for the enrichment."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata for the enrichment.",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "Identifier of the parent webset."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp of the enrichment."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Last update timestamp of the enrichment."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the enrichment."
              },
              "instructions": {
                "type": "string",
                "title": "Instructions",
                "description": "Instructions for the enrichment."
              }
            },
            "description": "Represents an enrichment task within the Webset."
          },
          "title": "Enrichments",
          "description": "Enrichments in the webset."
        }
      },
      "description": "Response schema for the created Webset."
    }
  },
  "title": "CreateWebsetResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "object",
        "status",
        "searches",
        "imports",
        "enrichments",
        "monitors",
        "streams",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the webset."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the webset, if set."
        },
        "object": {
          "type": "string",
          "const": "webset",
          "title": "Object",
          "description": "Object type."
        },
        "status": {
          "enum": [
            "idle",
            "pending",
            "running",
            "paused"
          ],
          "type": "string",
          "title": "Status",
          "description": "Status of the webset."
        },
        "imports": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImportItem",
            "required": [
              "id",
              "object",
              "status",
              "format",
              "entity",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the import."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Number of items in the import."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the import."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "properties": {
                  "type": {
                    "enum": [
                      "company",
                      "person",
                      "article",
                      "research_paper",
                      "custom"
                    ],
                    "type": "string",
                    "title": "Type",
                    "default": "company",
                    "description": "Allowed entity types for the search or import."
                  }
                },
                "description": "Entity type of the import."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "Format of the import."
              },
              "object": {
                "type": "string",
                "const": "import",
                "title": "Object",
                "description": "Object type, always 'import'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of the import."
              },
              "failedAt": {
                "type": "string",
                "title": "Failed At",
                "description": "Failure timestamp."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata for the import.",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp of the import."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Last update timestamp of the import."
              },
              "failedReason": {
                "type": "string",
                "title": "Failed Reason",
                "description": "Reason for import failure."
              },
              "failedMessage": {
                "type": "string",
                "title": "Failed Message",
                "description": "Failure message."
              }
            },
            "description": "Represents an import performed on the Webset."
          },
          "title": "Imports",
          "description": "Imports performed on the webset."
        },
        "streams": {
          "type": "array",
          "items": {},
          "title": "Streams",
          "description": "Streams associated with the webset."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Metadata for the webset.",
          "additionalProperties": true
        },
        "monitors": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MonitorItem",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "cadence",
              "behavior",
              "lastRun",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the monitor."
              },
              "object": {
                "type": "string",
                "const": "monitor",
                "title": "Object",
                "description": "Object type."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of the monitor."
              },
              "cadence": {
                "type": "object",
                "title": "Cadence",
                "required": [
                  "cron",
                  "timezone"
                ],
                "properties": {
                  "cron": {
                    "type": "string",
                    "title": "Cron",
                    "description": "Cron expression for scheduling."
                  },
                  "timezone": {
                    "type": "string",
                    "title": "Timezone",
                    "description": "Timezone for the schedule, e.g. 'Etc/UTC'."
                  }
                },
                "description": "Schedule cadence of the monitor."
              },
              "lastRun": {
                "type": "object",
                "title": "Last Run",
                "required": [
                  "id",
                  "object",
                  "status",
                  "monitorId",
                  "type",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Run identifier."
                  },
                  "type": {
                    "type": "string",
                    "const": "search",
                    "title": "Type",
                    "description": "Type of run."
                  },
                  "object": {
                    "type": "string",
                    "const": "monitor_run",
                    "title": "Object",
                    "description": "Object type."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Status of the run."
                  },
                  "failedAt": {
                    "type": "string",
                    "title": "Failed At",
                    "description": "Failure timestamp."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "Creation timestamp."
                  },
                  "monitorId": {
                    "type": "string",
                    "title": "Monitor Id",
                    "description": "Identifier of the monitor."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "Last update timestamp."
                  },
                  "canceledAt": {
                    "type": "string",
                    "title": "Canceled At",
                    "description": "Cancelation timestamp."
                  },
                  "completedAt": {
                    "type": "string",
                    "title": "Completed At",
                    "description": "Completion timestamp."
                  },
                  "failedReason": {
                    "type": "string",
                    "title": "Failed Reason",
                    "description": "Reason for failure."
                  }
                },
                "description": "Last run details."
              },
              "behavior": {
                "type": "object",
                "title": "Behavior",
                "required": [
                  "type",
                  "config"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "const": "search",
                    "title": "Type",
                    "description": "Type of monitor behavior."
                  },
                  "config": {
                    "type": "object",
                    "title": "Config",
                    "required": [
                      "query",
                      "criteria",
                      "entity",
                      "count",
                      "behavior"
                    ],
                    "properties": {
                      "count": {
                        "type": "integer",
                        "title": "Count",
                        "description": "Number of items to find each run."
                      },
                      "query": {
                        "type": "string",
                        "title": "Query",
                        "description": "Search query for monitor runs."
                      },
                      "entity": {
                        "type": "object",
                        "title": "Entity",
                        "properties": {
                          "type": {
                            "enum": [
                              "company",
                              "person",
                              "article",
                              "research_paper",
                              "custom"
                            ],
                            "type": "string",
                            "title": "Type",
                            "default": "company",
                            "description": "Allowed entity types for the search or import."
                          }
                        },
                        "description": "Entity type for the monitor."
                      },
                      "behavior": {
                        "type": "string",
                        "title": "Behavior",
                        "description": "Behavior mode for monitor, e.g. 'append'."
                      },
                      "criteria": {
                        "type": "array",
                        "items": {
                          "type": "object",
                          "title": "Criterion",
                          "required": [
                            "description"
                          ],
                          "properties": {
                            "description": {
                              "type": "string",
                              "title": "Description",
                              "description": "Description of the evaluation criterion."
                            },
                            "successRate": {
                              "type": "integer",
                              "title": "Success Rate",
                              "description": "Success rate percentage for this criterion."
                            }
                          },
                          "description": "Criterion to evaluate search results against."
                        },
                        "title": "Criteria",
                        "description": "Criteria to evaluate monitor results."
                      }
                    },
                    "description": "Monitor behavior configuration."
                  }
                },
                "description": "Monitor behavior details."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata for the monitor.",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "Identifier of the parent webset."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp of the monitor."
              },
              "nextRunAt": {
                "type": "string",
                "title": "Next Run At",
                "description": "Next scheduled run timestamp."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Last update timestamp of the monitor."
              }
            },
            "description": "Represents a monitor configured on the Webset."
          },
          "title": "Monitors",
          "description": "Monitors configured on the webset."
        },
        "searches": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebsetSearchItem",
            "required": [
              "id",
              "object",
              "status",
              "query",
              "entity",
              "criteria",
              "count",
              "behavior",
              "exclude",
              "scope",
              "progress",
              "recall",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the search."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Number of items requested to find."
              },
              "query": {
                "type": "string",
                "title": "Query",
                "description": "Search query used."
              },
              "scope": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "SourceItem",
                  "required": [
                    "source",
                    "id"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "Identifier of the source to include or exclude."
                    },
                    "source": {
                      "enum": [
                        "import",
                        "webset"
                      ],
                      "type": "string",
                      "title": "Source",
                      "description": "The type of source ('import' or 'webset')."
                    }
                  },
                  "description": "Source to include or exclude in search."
                },
                "title": "Scope",
                "description": "Sources specifically scoped for this search."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "properties": {
                  "type": {
                    "enum": [
                      "company",
                      "person",
                      "article",
                      "research_paper",
                      "custom"
                    ],
                    "type": "string",
                    "title": "Type",
                    "default": "company",
                    "description": "Allowed entity types for the search or import."
                  }
                },
                "description": "Entity type for the search."
              },
              "object": {
                "type": "string",
                "const": "webset_search",
                "title": "Object",
                "description": "Object type, always 'webset_search'."
              },
              "recall": {
                "type": "object",
                "title": "Recall",
                "required": [
                  "expected"
                ],
                "properties": {
                  "expected": {
                    "type": "object",
                    "title": "Expected",
                    "required": [
                      "total",
                      "confidence",
                      "bounds"
                    ],
                    "properties": {
                      "total": {
                        "type": "integer",
                        "title": "Total",
                        "description": "Estimated total relevant results."
                      },
                      "bounds": {
                        "type": "object",
                        "title": "Bounds",
                        "required": [
                          "min",
                          "max"
                        ],
                        "properties": {
                          "max": {
                            "type": "integer",
                            "title": "Max",
                            "description": "Maximum estimated count."
                          },
                          "min": {
                            "type": "integer",
                            "title": "Min",
                            "description": "Minimum estimated count."
                          }
                        },
                        "description": "Confidence bounds for the estimate."
                      },
                      "confidence": {
                        "enum": [
                          "low",
                          "medium",
                          "high"
                        ],
                        "type": "string",
                        "title": "Confidence",
                        "description": "Confidence level of the estimate."
                      }
                    },
                    "description": "Expected recall metrics."
                  },
                  "reasoning": {
                    "type": "string",
                    "title": "Reasoning",
                    "description": "Reasoning behind the recall estimate."
                  }
                },
                "description": "Recall metrics for the search."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of the search."
              },
              "exclude": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "SourceItem",
                  "required": [
                    "source",
                    "id"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "Identifier of the source to include or exclude."
                    },
                    "source": {
                      "enum": [
                        "import",
                        "webset"
                      ],
                      "type": "string",
                      "title": "Source",
                      "description": "The type of source ('import' or 'webset')."
                    }
                  },
                  "description": "Source to include or exclude in search."
                },
                "title": "Exclude",
                "description": "Sources excluded from this search."
              },
              "behavior": {
                "type": "string",
                "title": "Behavior",
                "description": "Behavior used for this search, e.g. 'override'."
              },
              "criteria": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Criterion",
                  "required": [
                    "description"
                  ],
                  "properties": {
                    "description": {
                      "type": "string",
                      "title": "Description",
                      "description": "Description of the evaluation criterion."
                    },
                    "successRate": {
                      "type": "integer",
                      "title": "Success Rate",
                      "description": "Success rate percentage for this criterion."
                    }
                  },
                  "description": "Criterion to evaluate search results against."
                },
                "title": "Criteria",
                "description": "Evaluation criteria used."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata for the search.",
                "additionalProperties": true
              },
              "progress": {
                "type": "object",
                "title": "Progress",
                "required": [
                  "found",
                  "analyzed",
                  "completion",
                  "timeLeft"
                ],
                "properties": {
                  "found": {
                    "type": "integer",
                    "title": "Found",
                    "description": "Number of items found so far."
                  },
                  "analyzed": {
                    "type": "integer",
                    "title": "Analyzed",
                    "description": "Number of items analyzed so far."
                  },
                  "timeLeft": {
                    "type": "integer",
                    "title": "Time Left",
                    "description": "Estimated time left in seconds."
                  },
                  "completion": {
                    "type": "integer",
                    "title": "Completion",
                    "description": "Percent completion of the search."
                  }
                },
                "description": "Progress metrics for the search."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp of the search."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Last update timestamp of the search."
              },
              "canceledAt": {
                "type": "string",
                "title": "Canceled At",
                "description": "Timestamp when search was canceled."
              },
              "canceledReason": {
                "type": "string",
                "title": "Canceled Reason",
                "description": "Reason search was canceled."
              }
            },
            "description": "Represents a search performed within the Webset."
          },
          "title": "Searches",
          "description": "Searches performed on the webset."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Creation timestamp of the webset."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Last update timestamp of the webset."
        },
        "externalId": {
          "type": "string",
          "title": "External Id",
          "description": "External identifier, if set."
        },
        "enrichments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "EnrichmentItem",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "title",
              "format",
              "options",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the enrichment."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the enrichment."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "Format of enrichment output."
              },
              "object": {
                "type": "string",
                "const": "webset_enrichment",
                "title": "Object",
                "description": "Object type."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of the enrichment."
              },
              "options": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "EnrichmentOption",
                  "required": [
                    "label"
                  ],
                  "properties": {
                    "label": {
                      "type": "string",
                      "title": "Label",
                      "description": "Label of the enrichment option."
                    }
                  },
                  "description": "Option for enrichment output."
                },
                "title": "Options",
                "description": "Available options for the enrichment."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Metadata for the enrichment.",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "Identifier of the parent webset."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Creation timestamp of the enrichment."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Last update timestamp of the enrichment."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the enrichment."
              },
              "instructions": {
                "type": "string",
                "title": "Instructions",
                "description": "Instructions for the enrichment."
              }
            },
            "description": "Represents an enrichment task within the Webset."
          },
          "title": "Enrichments",
          "description": "Enrichments in the webset."
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

## EXA_DELETE_IMPORT
Tool to delete an existing import. Use when you need to permanently remove an import by its ID.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteImportRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "import_id_123"
      ],
      "description": "The ID of the import to delete."
    }
  },
  "description": "Request model for deleting a specific import by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Entity": {
      "type": "object",
      "title": "Entity",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The type of entity the import contains (e.g., 'company', 'person')."
        }
      },
      "description": "Represents the entity type contained in the import object."
    },
    "DeleteImportResponse": {
      "type": "object",
      "title": "DeleteImportResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the Import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "The number of entities in the import."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of entity the import contains (e.g., 'company', 'person')."
            }
          },
          "description": "The type of entity the import contains."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "The format of the import (csv or webset)."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The type of object, always 'import'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the Import (pending, processing, completed, or failed)."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the import failed, if applicable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Key-value pairs associated with this import object.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the import was last updated."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "The reason the import failed, if any (invalid_format, invalid_file_content, or missing_identifier)."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "A human-readable message describing the import failure, if any."
        }
      },
      "description": "Response model returned after successfully deleting an import."
    }
  },
  "title": "DeleteImportResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the Import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "The number of entities in the import."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of entity the import contains (e.g., 'company', 'person')."
            }
          },
          "description": "The type of entity the import contains."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "The format of the import (csv or webset)."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The type of object, always 'import'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the Import (pending, processing, completed, or failed)."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the import failed, if applicable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Key-value pairs associated with this import object.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the import was last updated."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "The reason the import failed, if any (invalid_format, invalid_file_content, or missing_identifier)."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "A human-readable message describing the import failure, if any."
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

## EXA_DELETE_WEBSET
Tool to delete a Webset. Use after confirming the Webset ID to permanently remove the Webset and all its items.

**Input schema:**
```json
{
  "type": "object",
  "title": "DeleteWebsetRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "webset_id_123"
      ],
      "description": "The id or externalId of the Webset to delete."
    }
  },
  "description": "Request model for deleting a Webset by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Entity": {
      "type": "object",
      "title": "Entity",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The type of entity (e.g., 'company', 'person')."
        }
      },
      "description": "Represents the entity type used in searches or imports."
    },
    "Recall": {
      "type": "object",
      "title": "Recall",
      "required": [
        "expected"
      ],
      "properties": {
        "expected": {
          "type": "object",
          "title": "Expected",
          "required": [
            "total",
            "confidence",
            "bounds"
          ],
          "properties": {
            "total": {
              "type": "integer",
              "title": "Total",
              "description": "Total expected items."
            },
            "bounds": {
              "type": "object",
              "title": "Bounds",
              "required": [
                "min",
                "max"
              ],
              "properties": {
                "max": {
                  "type": "integer",
                  "title": "Max",
                  "description": "Maximum expected recall."
                },
                "min": {
                  "type": "integer",
                  "title": "Min",
                  "description": "Minimum expected recall."
                }
              },
              "description": "Bounds for recall metrics."
            },
            "confidence": {
              "type": "string",
              "title": "Confidence",
              "description": "Confidence level (e.g., 'high', 'medium')."
            }
          },
          "description": "Expected recall metrics."
        },
        "reasoning": {
          "type": "string",
          "title": "Reasoning",
          "description": "Reasoning behind the recall estimate."
        }
      },
      "description": "Recall metrics for a Webset search."
    },
    "Cadence": {
      "type": "object",
      "title": "Cadence",
      "required": [
        "cron",
        "timezone"
      ],
      "properties": {
        "cron": {
          "type": "string",
          "title": "Cron",
          "description": "Cron schedule string."
        },
        "timezone": {
          "type": "string",
          "title": "Timezone",
          "description": "Timezone for the schedule."
        }
      },
      "description": "Cadence configuration for a monitor."
    },
    "Behavior": {
      "type": "object",
      "title": "Behavior",
      "required": [
        "type",
        "config"
      ],
      "properties": {
        "type": {
          "type": "string",
          "const": "search",
          "title": "Type",
          "description": "Behavior type, always 'search'."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "required": [
            "query",
            "criteria",
            "entity",
            "count",
            "behavior"
          ],
          "properties": {
            "count": {
              "type": "integer",
              "title": "Count",
              "description": "Number of results to fetch on each run."
            },
            "query": {
              "type": "string",
              "title": "Query",
              "description": "Search query for the monitor."
            },
            "entity": {
              "type": "object",
              "title": "Entity",
              "required": [
                "type"
              ],
              "properties": {
                "type": {
                  "type": "string",
                  "title": "Type",
                  "description": "The type of entity (e.g., 'company', 'person')."
                }
              },
              "description": "Represents the entity type used in searches or imports."
            },
            "behavior": {
              "enum": [
                "override",
                "append"
              ],
              "type": "string",
              "title": "Behavior",
              "description": "Behavior when adding to the Webset."
            },
            "criteria": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Criteria",
                "required": [
                  "description"
                ],
                "properties": {
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "The description of the criterion."
                  },
                  "successRate": {
                    "type": "integer",
                    "title": "Success Rate",
                    "description": "The success rate percentage for this criterion, if available."
                  }
                },
                "description": "Represents a criterion used in a Webset search."
              },
              "title": "Criteria"
            }
          },
          "description": "Configuration for monitor behavior."
        }
      },
      "description": "Behavior settings for a monitor."
    },
    "Criteria": {
      "type": "object",
      "title": "Criteria",
      "required": [
        "description"
      ],
      "properties": {
        "description": {
          "type": "string",
          "title": "Description",
          "description": "The description of the criterion."
        },
        "successRate": {
          "type": "integer",
          "title": "Success Rate",
          "description": "The success rate percentage for this criterion, if available."
        }
      },
      "description": "Represents a criterion used in a Webset search."
    },
    "Progress": {
      "type": "object",
      "title": "Progress",
      "required": [
        "found",
        "analyzed",
        "completion",
        "timeLeft"
      ],
      "properties": {
        "found": {
          "type": "integer",
          "title": "Found",
          "description": "Number of items found so far."
        },
        "analyzed": {
          "type": "integer",
          "title": "Analyzed",
          "description": "Number of items analyzed so far."
        },
        "timeLeft": {
          "type": "integer",
          "title": "Time Left",
          "description": "Estimated time left in seconds."
        },
        "completion": {
          "type": "integer",
          "title": "Completion",
          "description": "Percentage of completion."
        }
      },
      "description": "Progress metrics for a Webset search."
    },
    "ImportObj": {
      "type": "object",
      "title": "ImportObj",
      "required": [
        "id",
        "object",
        "status",
        "format",
        "entity",
        "title",
        "count",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of entities imported."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title given to the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of entity (e.g., 'company', 'person')."
            }
          },
          "description": "Represents the entity type used in searches or imports."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "The format of the import (e.g., 'csv', 'webset')."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The object type, always 'import'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the import."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the import failed, if applicable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the import was last updated."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason for failure, if import failed."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "Human-readable message about import failure, if any."
        }
      },
      "description": "Represents an import object within a Webset."
    },
    "MonitorObj": {
      "type": "object",
      "title": "MonitorObj",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "cadence",
        "behavior",
        "lastRun",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the monitor."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The object type, always 'monitor'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the monitor."
        },
        "cadence": {
          "type": "object",
          "title": "Cadence",
          "required": [
            "cron",
            "timezone"
          ],
          "properties": {
            "cron": {
              "type": "string",
              "title": "Cron",
              "description": "Cron schedule string."
            },
            "timezone": {
              "type": "string",
              "title": "Timezone",
              "description": "Timezone for the schedule."
            }
          },
          "description": "Cadence configuration for a monitor."
        },
        "lastRun": {
          "type": "object",
          "title": "Last Run",
          "required": [
            "id",
            "object",
            "status",
            "monitorId",
            "type",
            "createdAt",
            "updatedAt"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "The unique identifier for the monitor run."
            },
            "type": {
              "type": "string",
              "const": "search",
              "title": "Type",
              "description": "Run type, always 'search'."
            },
            "object": {
              "type": "string",
              "title": "Object",
              "description": "The object type, always 'monitor_run'."
            },
            "status": {
              "type": "string",
              "title": "Status",
              "description": "Status of the monitor run."
            },
            "failedAt": {
              "type": "string",
              "title": "Failed At",
              "description": "Timestamp when the run failed, if applicable."
            },
            "createdAt": {
              "type": "string",
              "title": "Created At",
              "description": "Timestamp when the run was created."
            },
            "monitorId": {
              "type": "string",
              "title": "Monitor Id",
              "description": "The Monitor ID this run belongs to."
            },
            "updatedAt": {
              "type": "string",
              "title": "Updated At",
              "description": "Timestamp when the run was last updated."
            },
            "canceledAt": {
              "type": "string",
              "title": "Canceled At",
              "description": "Timestamp when the run was canceled, if applicable."
            },
            "completedAt": {
              "type": "string",
              "title": "Completed At",
              "description": "Timestamp when the run completed, if applicable."
            },
            "failedReason": {
              "type": "string",
              "title": "Failed Reason",
              "description": "Reason for failure, if any."
            }
          },
          "description": "Represents the last run details of a monitor."
        },
        "behavior": {
          "type": "object",
          "title": "Behavior",
          "required": [
            "type",
            "config"
          ],
          "properties": {
            "type": {
              "type": "string",
              "const": "search",
              "title": "Type",
              "description": "Behavior type, always 'search'."
            },
            "config": {
              "type": "object",
              "title": "Config",
              "required": [
                "query",
                "criteria",
                "entity",
                "count",
                "behavior"
              ],
              "properties": {
                "count": {
                  "type": "integer",
                  "title": "Count",
                  "description": "Number of results to fetch on each run."
                },
                "query": {
                  "type": "string",
                  "title": "Query",
                  "description": "Search query for the monitor."
                },
                "entity": {
                  "type": "object",
                  "title": "Entity",
                  "required": [
                    "type"
                  ],
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "The type of entity (e.g., 'company', 'person')."
                    }
                  },
                  "description": "Represents the entity type used in searches or imports."
                },
                "behavior": {
                  "enum": [
                    "override",
                    "append"
                  ],
                  "type": "string",
                  "title": "Behavior",
                  "description": "Behavior when adding to the Webset."
                },
                "criteria": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "title": "Criteria",
                    "required": [
                      "description"
                    ],
                    "properties": {
                      "description": {
                        "type": "string",
                        "title": "Description",
                        "description": "The description of the criterion."
                      },
                      "successRate": {
                        "type": "integer",
                        "title": "Success Rate",
                        "description": "The success rate percentage for this criterion, if available."
                      }
                    },
                    "description": "Represents a criterion used in a Webset search."
                  },
                  "title": "Criteria"
                }
              },
              "description": "Configuration for monitor behavior."
            }
          },
          "description": "Behavior settings for a monitor."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "additionalProperties": true
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "The associated Webset ID."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when monitor was created."
        },
        "nextRunAt": {
          "type": "string",
          "title": "Next Run At",
          "description": "Timestamp for next scheduled run."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when monitor was last updated."
        }
      },
      "description": "Represents a monitor configured on a Webset."
    },
    "ExcludeScope": {
      "type": "object",
      "title": "ExcludeScope",
      "required": [
        "source",
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The ID of the source to exclude or scope."
        },
        "source": {
          "type": "string",
          "title": "Source",
          "description": "The source type (e.g., 'import', 'webset')."
        }
      },
      "description": "Represents an excluded or scoped source in a Webset search."
    },
    "RecallBounds": {
      "type": "object",
      "title": "RecallBounds",
      "required": [
        "min",
        "max"
      ],
      "properties": {
        "max": {
          "type": "integer",
          "title": "Max",
          "description": "Maximum expected recall."
        },
        "min": {
          "type": "integer",
          "title": "Min",
          "description": "Minimum expected recall."
        }
      },
      "description": "Bounds for recall metrics."
    },
    "WebsetSearch": {
      "type": "object",
      "title": "WebsetSearch",
      "required": [
        "id",
        "object",
        "status",
        "query",
        "entity",
        "criteria",
        "count",
        "behavior",
        "exclude",
        "scope",
        "progress",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the search."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "minimum": 1,
          "description": "Number of results the search attempts to find."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "description": "The query used for the search."
        },
        "scope": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ExcludeScope",
            "required": [
              "source",
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The ID of the source to exclude or scope."
              },
              "source": {
                "type": "string",
                "title": "Source",
                "description": "The source type (e.g., 'import', 'webset')."
              }
            },
            "description": "Represents an excluded or scoped source in a Webset search."
          },
          "title": "Scope"
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of entity (e.g., 'company', 'person')."
            }
          },
          "description": "Represents the entity type used in searches or imports."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The object type, always 'webset_search'."
        },
        "recall": {
          "type": "object",
          "title": "Recall",
          "required": [
            "expected"
          ],
          "properties": {
            "expected": {
              "type": "object",
              "title": "Expected",
              "required": [
                "total",
                "confidence",
                "bounds"
              ],
              "properties": {
                "total": {
                  "type": "integer",
                  "title": "Total",
                  "description": "Total expected items."
                },
                "bounds": {
                  "type": "object",
                  "title": "Bounds",
                  "required": [
                    "min",
                    "max"
                  ],
                  "properties": {
                    "max": {
                      "type": "integer",
                      "title": "Max",
                      "description": "Maximum expected recall."
                    },
                    "min": {
                      "type": "integer",
                      "title": "Min",
                      "description": "Minimum expected recall."
                    }
                  },
                  "description": "Bounds for recall metrics."
                },
                "confidence": {
                  "type": "string",
                  "title": "Confidence",
                  "description": "Confidence level (e.g., 'high', 'medium')."
                }
              },
              "description": "Expected recall metrics."
            },
            "reasoning": {
              "type": "string",
              "title": "Reasoning",
              "description": "Reasoning behind the recall estimate."
            }
          },
          "description": "Recall metrics, if available."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the search."
        },
        "exclude": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ExcludeScope",
            "required": [
              "source",
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The ID of the source to exclude or scope."
              },
              "source": {
                "type": "string",
                "title": "Source",
                "description": "The source type (e.g., 'import', 'webset')."
              }
            },
            "description": "Represents an excluded or scoped source in a Webset search."
          },
          "title": "Exclude"
        },
        "behavior": {
          "enum": [
            "override",
            "append"
          ],
          "type": "string",
          "title": "Behavior",
          "description": "Behavior when adding to the Webset."
        },
        "criteria": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Criteria",
            "required": [
              "description"
            ],
            "properties": {
              "description": {
                "type": "string",
                "title": "Description",
                "description": "The description of the criterion."
              },
              "successRate": {
                "type": "integer",
                "title": "Success Rate",
                "description": "The success rate percentage for this criterion, if available."
              }
            },
            "description": "Represents a criterion used in a Webset search."
          },
          "title": "Criteria"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "additionalProperties": true
        },
        "progress": {
          "type": "object",
          "title": "Progress",
          "required": [
            "found",
            "analyzed",
            "completion",
            "timeLeft"
          ],
          "properties": {
            "found": {
              "type": "integer",
              "title": "Found",
              "description": "Number of items found so far."
            },
            "analyzed": {
              "type": "integer",
              "title": "Analyzed",
              "description": "Number of items analyzed so far."
            },
            "timeLeft": {
              "type": "integer",
              "title": "Time Left",
              "description": "Estimated time left in seconds."
            },
            "completion": {
              "type": "integer",
              "title": "Completion",
              "description": "Percentage of completion."
            }
          },
          "description": "Progress metrics for a Webset search."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the search was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the search was last updated."
        },
        "canceledAt": {
          "type": "string",
          "title": "Canceled At",
          "description": "Timestamp when the search was canceled, if applicable."
        },
        "canceledReason": {
          "enum": [
            "webset_deleted",
            "webset_canceled"
          ],
          "type": "string",
          "title": "Canceled Reason",
          "description": "Reason the search was canceled, if applicable."
        }
      },
      "description": "Represents a search operation within a Webset."
    },
    "BehaviorConfig": {
      "type": "object",
      "title": "BehaviorConfig",
      "required": [
        "query",
        "criteria",
        "entity",
        "count",
        "behavior"
      ],
      "properties": {
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of results to fetch on each run."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "description": "Search query for the monitor."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of entity (e.g., 'company', 'person')."
            }
          },
          "description": "Represents the entity type used in searches or imports."
        },
        "behavior": {
          "enum": [
            "override",
            "append"
          ],
          "type": "string",
          "title": "Behavior",
          "description": "Behavior when adding to the Webset."
        },
        "criteria": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Criteria",
            "required": [
              "description"
            ],
            "properties": {
              "description": {
                "type": "string",
                "title": "Description",
                "description": "The description of the criterion."
              },
              "successRate": {
                "type": "integer",
                "title": "Success Rate",
                "description": "The success rate percentage for this criterion, if available."
              }
            },
            "description": "Represents a criterion used in a Webset search."
          },
          "title": "Criteria"
        }
      },
      "description": "Configuration for monitor behavior."
    },
    "MonitorLastRun": {
      "type": "object",
      "title": "MonitorLastRun",
      "required": [
        "id",
        "object",
        "status",
        "monitorId",
        "type",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the monitor run."
        },
        "type": {
          "type": "string",
          "const": "search",
          "title": "Type",
          "description": "Run type, always 'search'."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The object type, always 'monitor_run'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the monitor run."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the run failed, if applicable."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the run was created."
        },
        "monitorId": {
          "type": "string",
          "title": "Monitor Id",
          "description": "The Monitor ID this run belongs to."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the run was last updated."
        },
        "canceledAt": {
          "type": "string",
          "title": "Canceled At",
          "description": "Timestamp when the run was canceled, if applicable."
        },
        "completedAt": {
          "type": "string",
          "title": "Completed At",
          "description": "Timestamp when the run completed, if applicable."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason for failure, if any."
        }
      },
      "description": "Represents the last run details of a monitor."
    },
    "RecallExpected": {
      "type": "object",
      "title": "RecallExpected",
      "required": [
        "total",
        "confidence",
        "bounds"
      ],
      "properties": {
        "total": {
          "type": "integer",
          "title": "Total",
          "description": "Total expected items."
        },
        "bounds": {
          "type": "object",
          "title": "Bounds",
          "required": [
            "min",
            "max"
          ],
          "properties": {
            "max": {
              "type": "integer",
              "title": "Max",
              "description": "Maximum expected recall."
            },
            "min": {
              "type": "integer",
              "title": "Min",
              "description": "Minimum expected recall."
            }
          },
          "description": "Bounds for recall metrics."
        },
        "confidence": {
          "type": "string",
          "title": "Confidence",
          "description": "Confidence level (e.g., 'high', 'medium')."
        }
      },
      "description": "Expected recall metrics."
    },
    "WebsetEnrichment": {
      "type": "object",
      "title": "WebsetEnrichment",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "description",
        "format",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the enrichment."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the enrichment, if available."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "The format of the enrichment response."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The object type, always 'webset_enrichment'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the enrichment."
        },
        "options": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebsetEnrichmentOption",
            "required": [
              "label"
            ],
            "properties": {
              "label": {
                "type": "string",
                "title": "Label",
                "description": "Option label."
              }
            },
            "description": "Option for a webset enrichment task."
          },
          "title": "Options",
          "description": "Options for enrichment if format is 'options'."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "additionalProperties": true
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "The Webset ID this enrichment belongs to."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when enrichment was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when enrichment was last updated."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description given for the enrichment task."
        },
        "instructions": {
          "type": "string",
          "title": "Instructions",
          "description": "Instructions for the enrichment agent, if any."
        }
      },
      "description": "Represents an enrichment task within a Webset."
    },
    "DeleteWebsetResponse": {
      "type": "object",
      "title": "DeleteWebsetResponse",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the Webset."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the Webset, if any."
        },
        "object": {
          "type": "string",
          "const": "webset",
          "title": "Object",
          "description": "Object type, always 'webset'."
        },
        "status": {
          "enum": [
            "idle",
            "pending",
            "running",
            "paused"
          ],
          "type": "string",
          "title": "Status",
          "description": "Status of the Webset."
        },
        "imports": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImportObj",
            "required": [
              "id",
              "object",
              "status",
              "format",
              "entity",
              "title",
              "count",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the import."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Number of entities imported."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title given to the import."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "required": [
                  "type"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "The type of entity (e.g., 'company', 'person')."
                  }
                },
                "description": "Represents the entity type used in searches or imports."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "The format of the import (e.g., 'csv', 'webset')."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "The object type, always 'import'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the import."
              },
              "failedAt": {
                "type": "string",
                "title": "Failed At",
                "description": "Timestamp when the import failed, if applicable."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when the import was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Timestamp when the import was last updated."
              },
              "failedReason": {
                "type": "string",
                "title": "Failed Reason",
                "description": "Reason for failure, if import failed."
              },
              "failedMessage": {
                "type": "string",
                "title": "Failed Message",
                "description": "Human-readable message about import failure, if any."
              }
            },
            "description": "Represents an import object within a Webset."
          },
          "title": "Imports"
        },
        "streams": {
          "type": "array",
          "items": {},
          "title": "Streams"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "additionalProperties": true
        },
        "monitors": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MonitorObj",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "cadence",
              "behavior",
              "lastRun",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the monitor."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "The object type, always 'monitor'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the monitor."
              },
              "cadence": {
                "type": "object",
                "title": "Cadence",
                "required": [
                  "cron",
                  "timezone"
                ],
                "properties": {
                  "cron": {
                    "type": "string",
                    "title": "Cron",
                    "description": "Cron schedule string."
                  },
                  "timezone": {
                    "type": "string",
                    "title": "Timezone",
                    "description": "Timezone for the schedule."
                  }
                },
                "description": "Cadence configuration for a monitor."
              },
              "lastRun": {
                "type": "object",
                "title": "Last Run",
                "required": [
                  "id",
                  "object",
                  "status",
                  "monitorId",
                  "type",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "The unique identifier for the monitor run."
                  },
                  "type": {
                    "type": "string",
                    "const": "search",
                    "title": "Type",
                    "description": "Run type, always 'search'."
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "The object type, always 'monitor_run'."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Status of the monitor run."
                  },
                  "failedAt": {
                    "type": "string",
                    "title": "Failed At",
                    "description": "Timestamp when the run failed, if applicable."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "Timestamp when the run was created."
                  },
                  "monitorId": {
                    "type": "string",
                    "title": "Monitor Id",
                    "description": "The Monitor ID this run belongs to."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "Timestamp when the run was last updated."
                  },
                  "canceledAt": {
                    "type": "string",
                    "title": "Canceled At",
                    "description": "Timestamp when the run was canceled, if applicable."
                  },
                  "completedAt": {
                    "type": "string",
                    "title": "Completed At",
                    "description": "Timestamp when the run completed, if applicable."
                  },
                  "failedReason": {
                    "type": "string",
                    "title": "Failed Reason",
                    "description": "Reason for failure, if any."
                  }
                },
                "description": "Represents the last run details of a monitor."
              },
              "behavior": {
                "type": "object",
                "title": "Behavior",
                "required": [
                  "type",
                  "config"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "const": "search",
                    "title": "Type",
                    "description": "Behavior type, always 'search'."
                  },
                  "config": {
                    "type": "object",
                    "title": "Config",
                    "required": [
                      "query",
                      "criteria",
                      "entity",
                      "count",
                      "behavior"
                    ],
                    "properties": {
                      "count": {
                        "type": "integer",
                        "title": "Count",
                        "description": "Number of results to fetch on each run."
                      },
                      "query": {
                        "type": "string",
                        "title": "Query",
                        "description": "Search query for the monitor."
                      },
                      "entity": {
                        "type": "object",
                        "title": "Entity",
                        "required": [
                          "type"
                        ],
                        "properties": {
                          "type": {
                            "type": "string",
                            "title": "Type",
                            "description": "The type of entity (e.g., 'company', 'person')."
                          }
                        },
                        "description": "Represents the entity type used in searches or imports."
                      },
                      "behavior": {
                        "enum": [
                          "override",
                          "append"
                        ],
                        "type": "string",
                        "title": "Behavior",
                        "description": "Behavior when adding to the Webset."
                      },
                      "criteria": {
                        "type": "array",
                        "items": {
                          "type": "object",
                          "title": "Criteria",
                          "required": [
                            "description"
                          ],
                          "properties": {
                            "description": {
                              "type": "string",
                              "title": "Description",
                              "description": "The description of the criterion."
                            },
                            "successRate": {
                              "type": "integer",
                              "title": "Success Rate",
                              "description": "The success rate percentage for this criterion, if available."
                            }
                          },
                          "description": "Represents a criterion used in a Webset search."
                        },
                        "title": "Criteria"
                      }
                    },
                    "description": "Configuration for monitor behavior."
                  }
                },
                "description": "Behavior settings for a monitor."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "The associated Webset ID."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when monitor was created."
              },
              "nextRunAt": {
                "type": "string",
                "title": "Next Run At",
                "description": "Timestamp for next scheduled run."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Timestamp when monitor was last updated."
              }
            },
            "description": "Represents a monitor configured on a Webset."
          },
          "title": "Monitors"
        },
        "searches": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebsetSearch",
            "required": [
              "id",
              "object",
              "status",
              "query",
              "entity",
              "criteria",
              "count",
              "behavior",
              "exclude",
              "scope",
              "progress",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the search."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "minimum": 1,
                "description": "Number of results the search attempts to find."
              },
              "query": {
                "type": "string",
                "title": "Query",
                "description": "The query used for the search."
              },
              "scope": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "ExcludeScope",
                  "required": [
                    "source",
                    "id"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "The ID of the source to exclude or scope."
                    },
                    "source": {
                      "type": "string",
                      "title": "Source",
                      "description": "The source type (e.g., 'import', 'webset')."
                    }
                  },
                  "description": "Represents an excluded or scoped source in a Webset search."
                },
                "title": "Scope"
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "required": [
                  "type"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "The type of entity (e.g., 'company', 'person')."
                  }
                },
                "description": "Represents the entity type used in searches or imports."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "The object type, always 'webset_search'."
              },
              "recall": {
                "type": "object",
                "title": "Recall",
                "required": [
                  "expected"
                ],
                "properties": {
                  "expected": {
                    "type": "object",
                    "title": "Expected",
                    "required": [
                      "total",
                      "confidence",
                      "bounds"
                    ],
                    "properties": {
                      "total": {
                        "type": "integer",
                        "title": "Total",
                        "description": "Total expected items."
                      },
                      "bounds": {
                        "type": "object",
                        "title": "Bounds",
                        "required": [
                          "min",
                          "max"
                        ],
                        "properties": {
                          "max": {
                            "type": "integer",
                            "title": "Max",
                            "description": "Maximum expected recall."
                          },
                          "min": {
                            "type": "integer",
                            "title": "Min",
                            "description": "Minimum expected recall."
                          }
                        },
                        "description": "Bounds for recall metrics."
                      },
                      "confidence": {
                        "type": "string",
                        "title": "Confidence",
                        "description": "Confidence level (e.g., 'high', 'medium')."
                      }
                    },
                    "description": "Expected recall metrics."
                  },
                  "reasoning": {
                    "type": "string",
                    "title": "Reasoning",
                    "description": "Reasoning behind the recall estimate."
                  }
                },
                "description": "Recall metrics, if available."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the search."
              },
              "exclude": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "ExcludeScope",
                  "required": [
                    "source",
                    "id"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "The ID of the source to exclude or scope."
                    },
                    "source": {
                      "type": "string",
                      "title": "Source",
                      "description": "The source type (e.g., 'import', 'webset')."
                    }
                  },
                  "description": "Represents an excluded or scoped source in a Webset search."
                },
                "title": "Exclude"
              },
              "behavior": {
                "enum": [
                  "override",
                  "append"
                ],
                "type": "string",
                "title": "Behavior",
                "description": "Behavior when adding to the Webset."
              },
              "criteria": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Criteria",
                  "required": [
                    "description"
                  ],
                  "properties": {
                    "description": {
                      "type": "string",
                      "title": "Description",
                      "description": "The description of the criterion."
                    },
                    "successRate": {
                      "type": "integer",
                      "title": "Success Rate",
                      "description": "The success rate percentage for this criterion, if available."
                    }
                  },
                  "description": "Represents a criterion used in a Webset search."
                },
                "title": "Criteria"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "additionalProperties": true
              },
              "progress": {
                "type": "object",
                "title": "Progress",
                "required": [
                  "found",
                  "analyzed",
                  "completion",
                  "timeLeft"
                ],
                "properties": {
                  "found": {
                    "type": "integer",
                    "title": "Found",
                    "description": "Number of items found so far."
                  },
                  "analyzed": {
                    "type": "integer",
                    "title": "Analyzed",
                    "description": "Number of items analyzed so far."
                  },
                  "timeLeft": {
                    "type": "integer",
                    "title": "Time Left",
                    "description": "Estimated time left in seconds."
                  },
                  "completion": {
                    "type": "integer",
                    "title": "Completion",
                    "description": "Percentage of completion."
                  }
                },
                "description": "Progress metrics for a Webset search."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when the search was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Timestamp when the search was last updated."
              },
              "canceledAt": {
                "type": "string",
                "title": "Canceled At",
                "description": "Timestamp when the search was canceled, if applicable."
              },
              "canceledReason": {
                "enum": [
                  "webset_deleted",
                  "webset_canceled"
                ],
                "type": "string",
                "title": "Canceled Reason",
                "description": "Reason the search was canceled, if applicable."
              }
            },
            "description": "Represents a search operation within a Webset."
          },
          "title": "Searches"
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when Webset was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when Webset was last updated."
        },
        "externalId": {
          "type": "string",
          "title": "External Id",
          "description": "External identifier for the Webset, if any."
        },
        "enrichments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebsetEnrichment",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "description",
              "format",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the enrichment."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the enrichment, if available."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "The format of the enrichment response."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "The object type, always 'webset_enrichment'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the enrichment."
              },
              "options": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "WebsetEnrichmentOption",
                  "required": [
                    "label"
                  ],
                  "properties": {
                    "label": {
                      "type": "string",
                      "title": "Label",
                      "description": "Option label."
                    }
                  },
                  "description": "Option for a webset enrichment task."
                },
                "title": "Options",
                "description": "Options for enrichment if format is 'options'."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "The Webset ID this enrichment belongs to."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when enrichment was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Timestamp when enrichment was last updated."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description given for the enrichment task."
              },
              "instructions": {
                "type": "string",
                "title": "Instructions",
                "description": "Instructions for the enrichment agent, if any."
              }
            },
            "description": "Represents an enrichment task within a Webset."
          },
          "title": "Enrichments"
        }
      },
      "description": "Response model returned after deleting a Webset."
    },
    "WebsetEnrichmentOption": {
      "type": "object",
      "title": "WebsetEnrichmentOption",
      "required": [
        "label"
      ],
      "properties": {
        "label": {
          "type": "string",
          "title": "Label",
          "description": "Option label."
        }
      },
      "description": "Option for a webset enrichment task."
    }
  },
  "title": "DeleteWebsetResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the Webset."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the Webset, if any."
        },
        "object": {
          "type": "string",
          "const": "webset",
          "title": "Object",
          "description": "Object type, always 'webset'."
        },
        "status": {
          "enum": [
            "idle",
            "pending",
            "running",
            "paused"
          ],
          "type": "string",
          "title": "Status",
          "description": "Status of the Webset."
        },
        "imports": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImportObj",
            "required": [
              "id",
              "object",
              "status",
              "format",
              "entity",
              "title",
              "count",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the import."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Number of entities imported."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title given to the import."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "required": [
                  "type"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "The type of entity (e.g., 'company', 'person')."
                  }
                },
                "description": "Represents the entity type used in searches or imports."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "The format of the import (e.g., 'csv', 'webset')."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "The object type, always 'import'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the import."
              },
              "failedAt": {
                "type": "string",
                "title": "Failed At",
                "description": "Timestamp when the import failed, if applicable."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when the import was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Timestamp when the import was last updated."
              },
              "failedReason": {
                "type": "string",
                "title": "Failed Reason",
                "description": "Reason for failure, if import failed."
              },
              "failedMessage": {
                "type": "string",
                "title": "Failed Message",
                "description": "Human-readable message about import failure, if any."
              }
            },
            "description": "Represents an import object within a Webset."
          },
          "title": "Imports"
        },
        "streams": {
          "type": "array",
          "items": {},
          "title": "Streams"
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "additionalProperties": true
        },
        "monitors": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "MonitorObj",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "cadence",
              "behavior",
              "lastRun",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the monitor."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "The object type, always 'monitor'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the monitor."
              },
              "cadence": {
                "type": "object",
                "title": "Cadence",
                "required": [
                  "cron",
                  "timezone"
                ],
                "properties": {
                  "cron": {
                    "type": "string",
                    "title": "Cron",
                    "description": "Cron schedule string."
                  },
                  "timezone": {
                    "type": "string",
                    "title": "Timezone",
                    "description": "Timezone for the schedule."
                  }
                },
                "description": "Cadence configuration for a monitor."
              },
              "lastRun": {
                "type": "object",
                "title": "Last Run",
                "required": [
                  "id",
                  "object",
                  "status",
                  "monitorId",
                  "type",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "The unique identifier for the monitor run."
                  },
                  "type": {
                    "type": "string",
                    "const": "search",
                    "title": "Type",
                    "description": "Run type, always 'search'."
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "The object type, always 'monitor_run'."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Status of the monitor run."
                  },
                  "failedAt": {
                    "type": "string",
                    "title": "Failed At",
                    "description": "Timestamp when the run failed, if applicable."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "Timestamp when the run was created."
                  },
                  "monitorId": {
                    "type": "string",
                    "title": "Monitor Id",
                    "description": "The Monitor ID this run belongs to."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "Timestamp when the run was last updated."
                  },
                  "canceledAt": {
                    "type": "string",
                    "title": "Canceled At",
                    "description": "Timestamp when the run was canceled, if applicable."
                  },
                  "completedAt": {
                    "type": "string",
                    "title": "Completed At",
                    "description": "Timestamp when the run completed, if applicable."
                  },
                  "failedReason": {
                    "type": "string",
                    "title": "Failed Reason",
                    "description": "Reason for failure, if any."
                  }
                },
                "description": "Represents the last run details of a monitor."
              },
              "behavior": {
                "type": "object",
                "title": "Behavior",
                "required": [
                  "type",
                  "config"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "const": "search",
                    "title": "Type",
                    "description": "Behavior type, always 'search'."
                  },
                  "config": {
                    "type": "object",
                    "title": "Config",
                    "required": [
                      "query",
                      "criteria",
                      "entity",
                      "count",
                      "behavior"
                    ],
                    "properties": {
                      "count": {
                        "type": "integer",
                        "title": "Count",
                        "description": "Number of results to fetch on each run."
                      },
                      "query": {
                        "type": "string",
                        "title": "Query",
                        "description": "Search query for the monitor."
                      },
                      "entity": {
                        "type": "object",
                        "title": "Entity",
                        "required": [
                          "type"
                        ],
                        "properties": {
                          "type": {
                            "type": "string",
                            "title": "Type",
                            "description": "The type of entity (e.g., 'company', 'person')."
                          }
                        },
                        "description": "Represents the entity type used in searches or imports."
                      },
                      "behavior": {
                        "enum": [
                          "override",
                          "append"
                        ],
                        "type": "string",
                        "title": "Behavior",
                        "description": "Behavior when adding to the Webset."
                      },
                      "criteria": {
                        "type": "array",
                        "items": {
                          "type": "object",
                          "title": "Criteria",
                          "required": [
                            "description"
                          ],
                          "properties": {
                            "description": {
                              "type": "string",
                              "title": "Description",
                              "description": "The description of the criterion."
                            },
                            "successRate": {
                              "type": "integer",
                              "title": "Success Rate",
                              "description": "The success rate percentage for this criterion, if available."
                            }
                          },
                          "description": "Represents a criterion used in a Webset search."
                        },
                        "title": "Criteria"
                      }
                    },
                    "description": "Configuration for monitor behavior."
                  }
                },
                "description": "Behavior settings for a monitor."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "The associated Webset ID."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when monitor was created."
              },
              "nextRunAt": {
                "type": "string",
                "title": "Next Run At",
                "description": "Timestamp for next scheduled run."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Timestamp when monitor was last updated."
              }
            },
            "description": "Represents a monitor configured on a Webset."
          },
          "title": "Monitors"
        },
        "searches": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebsetSearch",
            "required": [
              "id",
              "object",
              "status",
              "query",
              "entity",
              "criteria",
              "count",
              "behavior",
              "exclude",
              "scope",
              "progress",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the search."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "minimum": 1,
                "description": "Number of results the search attempts to find."
              },
              "query": {
                "type": "string",
                "title": "Query",
                "description": "The query used for the search."
              },
              "scope": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "ExcludeScope",
                  "required": [
                    "source",
                    "id"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "The ID of the source to exclude or scope."
                    },
                    "source": {
                      "type": "string",
                      "title": "Source",
                      "description": "The source type (e.g., 'import', 'webset')."
                    }
                  },
                  "description": "Represents an excluded or scoped source in a Webset search."
                },
                "title": "Scope"
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "required": [
                  "type"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "The type of entity (e.g., 'company', 'person')."
                  }
                },
                "description": "Represents the entity type used in searches or imports."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "The object type, always 'webset_search'."
              },
              "recall": {
                "type": "object",
                "title": "Recall",
                "required": [
                  "expected"
                ],
                "properties": {
                  "expected": {
                    "type": "object",
                    "title": "Expected",
                    "required": [
                      "total",
                      "confidence",
                      "bounds"
                    ],
                    "properties": {
                      "total": {
                        "type": "integer",
                        "title": "Total",
                        "description": "Total expected items."
                      },
                      "bounds": {
                        "type": "object",
                        "title": "Bounds",
                        "required": [
                          "min",
                          "max"
                        ],
                        "properties": {
                          "max": {
                            "type": "integer",
                            "title": "Max",
                            "description": "Maximum expected recall."
                          },
                          "min": {
                            "type": "integer",
                            "title": "Min",
                            "description": "Minimum expected recall."
                          }
                        },
                        "description": "Bounds for recall metrics."
                      },
                      "confidence": {
                        "type": "string",
                        "title": "Confidence",
                        "description": "Confidence level (e.g., 'high', 'medium')."
                      }
                    },
                    "description": "Expected recall metrics."
                  },
                  "reasoning": {
                    "type": "string",
                    "title": "Reasoning",
                    "description": "Reasoning behind the recall estimate."
                  }
                },
                "description": "Recall metrics, if available."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the search."
              },
              "exclude": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "ExcludeScope",
                  "required": [
                    "source",
                    "id"
                  ],
                  "properties": {
                    "id": {
                      "type": "string",
                      "title": "Id",
                      "description": "The ID of the source to exclude or scope."
                    },
                    "source": {
                      "type": "string",
                      "title": "Source",
                      "description": "The source type (e.g., 'import', 'webset')."
                    }
                  },
                  "description": "Represents an excluded or scoped source in a Webset search."
                },
                "title": "Exclude"
              },
              "behavior": {
                "enum": [
                  "override",
                  "append"
                ],
                "type": "string",
                "title": "Behavior",
                "description": "Behavior when adding to the Webset."
              },
              "criteria": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Criteria",
                  "required": [
                    "description"
                  ],
                  "properties": {
                    "description": {
                      "type": "string",
                      "title": "Description",
                      "description": "The description of the criterion."
                    },
                    "successRate": {
                      "type": "integer",
                      "title": "Success Rate",
                      "description": "The success rate percentage for this criterion, if available."
                    }
                  },
                  "description": "Represents a criterion used in a Webset search."
                },
                "title": "Criteria"
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "additionalProperties": true
              },
              "progress": {
                "type": "object",
                "title": "Progress",
                "required": [
                  "found",
                  "analyzed",
                  "completion",
                  "timeLeft"
                ],
                "properties": {
                  "found": {
                    "type": "integer",
                    "title": "Found",
                    "description": "Number of items found so far."
                  },
                  "analyzed": {
                    "type": "integer",
                    "title": "Analyzed",
                    "description": "Number of items analyzed so far."
                  },
                  "timeLeft": {
                    "type": "integer",
                    "title": "Time Left",
                    "description": "Estimated time left in seconds."
                  },
                  "completion": {
                    "type": "integer",
                    "title": "Completion",
                    "description": "Percentage of completion."
                  }
                },
                "description": "Progress metrics for a Webset search."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when the search was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Timestamp when the search was last updated."
              },
              "canceledAt": {
                "type": "string",
                "title": "Canceled At",
                "description": "Timestamp when the search was canceled, if applicable."
              },
              "canceledReason": {
                "enum": [
                  "webset_deleted",
                  "webset_canceled"
                ],
                "type": "string",
                "title": "Canceled Reason",
                "description": "Reason the search was canceled, if applicable."
              }
            },
            "description": "Represents a search operation within a Webset."
          },
          "title": "Searches"
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when Webset was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when Webset was last updated."
        },
        "externalId": {
          "type": "string",
          "title": "External Id",
          "description": "External identifier for the Webset, if any."
        },
        "enrichments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "WebsetEnrichment",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "description",
              "format",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the enrichment."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the enrichment, if available."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "The format of the enrichment response."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "The object type, always 'webset_enrichment'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the enrichment."
              },
              "options": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "WebsetEnrichmentOption",
                  "required": [
                    "label"
                  ],
                  "properties": {
                    "label": {
                      "type": "string",
                      "title": "Label",
                      "description": "Option label."
                    }
                  },
                  "description": "Option for a webset enrichment task."
                },
                "title": "Options",
                "description": "Options for enrichment if format is 'options'."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "The Webset ID this enrichment belongs to."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when enrichment was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "Timestamp when enrichment was last updated."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description given for the enrichment task."
              },
              "instructions": {
                "type": "string",
                "title": "Instructions",
                "description": "Instructions for the enrichment agent, if any."
              }
            },
            "description": "Represents an enrichment task within a Webset."
          },
          "title": "Enrichments"
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

## EXA_FIND_SIMILAR
DEPRECATED: /findSimilar is a legacy endpoint and is no longer recommended for new integrations. Migrate to EXA_SEARCH with type='deep-lite' or 'deep' passing a URL-shaped query, optionally with the nested `contents` object for enrichment. Existing calls continue to work for now. Finds web pages semantically similar to a given URL using embeddings-based search, optionally retrieving full text, highlights, or summaries for results.

**Input schema:**
```json
{
  "type": "object",
  "title": "FindSimilarRequest",
  "required": [
    "url"
  ],
  "properties": {
    "url": {
      "type": "string",
      "title": "Url",
      "examples": [
        "https://arxiv.org/abs/2307.06435"
      ],
      "description": "The URL for which to find semantically similar web pages. This must be a valid and accessible web address. Must be fully qualified (include scheme and domain); do not pass partial paths, redirect stubs, or snippet text. Specific, content-rich URLs yield more diverse results than generic landing pages."
    },
    "text": {
      "type": "boolean",
      "title": "Text",
      "default": false,
      "description": "Set to true to request the full text content of each similar page. Defaults to false. Combining text=true with large num_results produces very large payloads; prefer highlights or summary when processing size is constrained."
    },
    "summary": {
      "type": "boolean",
      "title": "Summary",
      "default": false,
      "description": "Set to true to request a generated summary for each similar page. Defaults to false."
    },
    "highlights": {
      "type": "boolean",
      "title": "Highlights",
      "default": false,
      "description": "Set to true to request relevant text snippets (highlights) from each similar page. Defaults to false."
    },
    "num_results": {
      "type": "integer",
      "title": "Num Results",
      "default": 10,
      "maximum": 100,
      "minimum": 1,
      "examples": [
        "10"
      ],
      "description": "The desired number of similar web pages to return. Must be an integer between 1 and 100, inclusive. Defaults to 10."
    }
  }
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Result": {
      "type": "object",
      "title": "Result",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "A unique temporary identifier for this search result document."
        },
        "url": {
          "type": "string",
          "title": "Url",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "The URL of the search result."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The full text content of the search result page. Populated if `text` was true in the request."
        },
        "image": {
          "type": "string",
          "title": "Image",
          "description": "The URL of an image associated with the search result, if available."
        },
        "score": {
          "type": "number",
          "title": "Score",
          "description": "A numerical score from 0 to 1 representing the semantic similarity between the input URL and this search result. Higher scores indicate greater similarity."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the search result."
        },
        "author": {
          "type": "string",
          "title": "Author",
          "description": "The author of the content, if available."
        },
        "extras": {
          "type": "object",
          "title": "Extras",
          "properties": {
            "links": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Links",
              "description": "A list of URLs for web links found within the content of the search result page."
            }
          },
          "description": "Additional information or links extracted from the search result."
        },
        "favicon": {
          "type": "string",
          "title": "Favicon",
          "description": "The URL of the favicon for the search result's domain, if available."
        },
        "summary": {
          "type": "string",
          "title": "Summary",
          "description": "A generated summary of the search result page. Populated if `summary` was true in the request."
        },
        "subpages": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Subpages",
          "description": "An array of dictionaries, where each dictionary represents a subpage related to the main search result. The structure of these dictionaries may vary."
        },
        "highlights": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Highlights",
          "description": "A list of relevant text snippets extracted from the search result's content. Populated if `highlights` was true in the request."
        },
        "publishedDate": {
          "type": "string",
          "title": "Published Date",
          "description": "An estimated creation date of the content, typically parsed from HTML."
        },
        "highlightScores": {
          "type": "array",
          "items": {
            "type": "number"
          },
          "title": "Highlight Scores",
          "description": "A list of cosine similarity scores, corresponding to each snippet in the `highlights` array, indicating the relevance of each highlight."
        }
      }
    },
    "CostDetail": {
      "type": "object",
      "title": "CostDetail",
      "properties": {
        "search": {
          "type": "number",
          "title": "Search",
          "description": "Total cost related to search operations (e.g., keyword or neural)."
        },
        "contents": {
          "type": "number",
          "title": "Contents",
          "description": "Total cost related to content retrieval operations (e.g., text, highlights, summary)."
        },
        "breakdown": {
          "type": "object",
          "title": "Breakdown",
          "properties": {
            "contentText": {
              "type": "number",
              "title": "Content Text",
              "description": "Cost attributed to retrieving full text content for this request."
            },
            "neuralSearch": {
              "type": "number",
              "title": "Neural Search",
              "description": "Cost attributed to neural search operations for this request."
            },
            "keywordSearch": {
              "type": "number",
              "title": "Keyword Search",
              "description": "Cost attributed to keyword search operations for this request."
            },
            "contentSummary": {
              "type": "number",
              "title": "Content Summary",
              "description": "Cost attributed to generating summaries for this request."
            },
            "contentHighlight": {
              "type": "number",
              "title": "Content Highlight",
              "description": "Cost attributed to generating highlights for this request."
            }
          },
          "description": "A detailed breakdown of costs by specific operation type."
        }
      }
    },
    "CostDollars": {
      "type": "object",
      "title": "CostDollars",
      "required": [
        "total"
      ],
      "properties": {
        "total": {
          "type": "number",
          "title": "Total",
          "description": "The total monetary cost for the entire request, in dollars."
        },
        "breakDown": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CostDetail",
            "properties": {
              "search": {
                "type": "number",
                "title": "Search",
                "description": "Total cost related to search operations (e.g., keyword or neural)."
              },
              "contents": {
                "type": "number",
                "title": "Contents",
                "description": "Total cost related to content retrieval operations (e.g., text, highlights, summary)."
              },
              "breakdown": {
                "type": "object",
                "title": "Breakdown",
                "properties": {
                  "contentText": {
                    "type": "number",
                    "title": "Content Text",
                    "description": "Cost attributed to retrieving full text content for this request."
                  },
                  "neuralSearch": {
                    "type": "number",
                    "title": "Neural Search",
                    "description": "Cost attributed to neural search operations for this request."
                  },
                  "keywordSearch": {
                    "type": "number",
                    "title": "Keyword Search",
                    "description": "Cost attributed to keyword search operations for this request."
                  },
                  "contentSummary": {
                    "type": "number",
                    "title": "Content Summary",
                    "description": "Cost attributed to generating summaries for this request."
                  },
                  "contentHighlight": {
                    "type": "number",
                    "title": "Content Highlight",
                    "description": "Cost attributed to generating highlights for this request."
                  }
                },
                "description": "A detailed breakdown of costs by specific operation type."
              }
            }
          },
          "title": "Break Down",
          "description": "A detailed breakdown of costs, categorizing them by the type of operation performed."
        },
        "perPagePrices": {
          "type": "object",
          "title": "Per Page Prices",
          "properties": {
            "contentText": {
              "type": "number",
              "title": "Content Text",
              "description": "Standard price per page for retrieving full text content."
            },
            "contentSummary": {
              "type": "number",
              "title": "Content Summary",
              "description": "Standard price per page for generating summaries."
            },
            "contentHighlight": {
              "type": "number",
              "title": "Content Highlight",
              "description": "Standard price per page for generating highlights."
            }
          },
          "description": "Standard pricing details for various content retrieval operations on a per-page basis."
        },
        "perRequestPrices": {
          "type": "object",
          "title": "Per Request Prices",
          "properties": {
            "neuralSearch_1_25_results": {
              "type": "number",
              "title": "Neural Search 1 25 Results",
              "description": "Standard price for a neural search operation returning 1-25 results."
            },
            "keywordSearch_1_100_results": {
              "type": "number",
              "title": "Keyword Search 1 100 Results",
              "description": "Standard price for a keyword search operation returning 1-100 results."
            },
            "neuralSearch_26_100_results": {
              "type": "number",
              "title": "Neural Search 26 100 Results",
              "description": "Standard price for a neural search operation returning 26-100 results."
            },
            "neuralSearch_100_plus_results": {
              "type": "number",
              "title": "Neural Search 100 Plus Results",
              "description": "Standard price for a neural search operation returning 100+ results."
            },
            "keywordSearch_100_plus_results": {
              "type": "number",
              "title": "Keyword Search 100 Plus Results",
              "description": "Standard price for a keyword search operation returning 100+ results."
            }
          },
          "description": "Standard pricing details for various search operations on a per-request basis."
        }
      }
    },
    "ResultExtras": {
      "type": "object",
      "title": "ResultExtras",
      "properties": {
        "links": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Links",
          "description": "A list of URLs for web links found within the content of the search result page."
        }
      }
    },
    "CostBreakdown": {
      "type": "object",
      "title": "CostBreakdown",
      "properties": {
        "contentText": {
          "type": "number",
          "title": "Content Text",
          "description": "Cost attributed to retrieving full text content for this request."
        },
        "neuralSearch": {
          "type": "number",
          "title": "Neural Search",
          "description": "Cost attributed to neural search operations for this request."
        },
        "keywordSearch": {
          "type": "number",
          "title": "Keyword Search",
          "description": "Cost attributed to keyword search operations for this request."
        },
        "contentSummary": {
          "type": "number",
          "title": "Content Summary",
          "description": "Cost attributed to generating summaries for this request."
        },
        "contentHighlight": {
          "type": "number",
          "title": "Content Highlight",
          "description": "Cost attributed to generating highlights for this request."
        }
      }
    },
    "PerPagePrices": {
      "type": "object",
      "title": "PerPagePrices",
      "properties": {
        "contentText": {
          "type": "number",
          "title": "Content Text",
          "description": "Standard price per page for retrieving full text content."
        },
        "contentSummary": {
          "type": "number",
          "title": "Content Summary",
          "description": "Standard price per page for generating summaries."
        },
        "contentHighlight": {
          "type": "number",
          "title": "Content Highlight",
          "description": "Standard price per page for generating highlights."
        }
      }
    },
    "PerRequestPrices": {
      "type": "object",
      "title": "PerRequestPrices",
      "properties": {
        "neuralSearch_1_25_results": {
          "type": "number",
          "title": "Neural Search 1 25 Results",
          "description": "Standard price for a neural search operation returning 1-25 results."
        },
        "keywordSearch_1_100_results": {
          "type": "number",
          "title": "Keyword Search 1 100 Results",
          "description": "Standard price for a keyword search operation returning 1-100 results."
        },
        "neuralSearch_26_100_results": {
          "type": "number",
          "title": "Neural Search 26 100 Results",
          "description": "Standard price for a neural search operation returning 26-100 results."
        },
        "neuralSearch_100_plus_results": {
          "type": "number",
          "title": "Neural Search 100 Plus Results",
          "description": "Standard price for a neural search operation returning 100+ results."
        },
        "keywordSearch_100_plus_results": {
          "type": "number",
          "title": "Keyword Search 100 Plus Results",
          "description": "Standard price for a keyword search operation returning 100+ results."
        }
      }
    },
    "FindSimilarResponse": {
      "type": "object",
      "title": "FindSimilarResponse",
      "required": [
        "requestId",
        "results",
        "costDollars"
      ],
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Result",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "A unique temporary identifier for this search result document."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "The URL of the search result."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The full text content of the search result page. Populated if `text` was true in the request."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "The URL of an image associated with the search result, if available."
              },
              "score": {
                "type": "number",
                "title": "Score",
                "description": "A numerical score from 0 to 1 representing the semantic similarity between the input URL and this search result. Higher scores indicate greater similarity."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the search result."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "The author of the content, if available."
              },
              "extras": {
                "type": "object",
                "title": "Extras",
                "properties": {
                  "links": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Links",
                    "description": "A list of URLs for web links found within the content of the search result page."
                  }
                },
                "description": "Additional information or links extracted from the search result."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "The URL of the favicon for the search result's domain, if available."
              },
              "summary": {
                "type": "string",
                "title": "Summary",
                "description": "A generated summary of the search result page. Populated if `summary` was true in the request."
              },
              "subpages": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Subpages",
                "description": "An array of dictionaries, where each dictionary represents a subpage related to the main search result. The structure of these dictionaries may vary."
              },
              "highlights": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Highlights",
                "description": "A list of relevant text snippets extracted from the search result's content. Populated if `highlights` was true in the request."
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "An estimated creation date of the content, typically parsed from HTML."
              },
              "highlightScores": {
                "type": "array",
                "items": {
                  "type": "number"
                },
                "title": "Highlight Scores",
                "description": "A list of cosine similarity scores, corresponding to each snippet in the `highlights` array, indicating the relevance of each highlight."
              }
            }
          },
          "title": "Results",
          "description": "A list of `Result` objects, each detailing a web page found to be similar to the input URL. Contains metadata, similarity scores, and any additionally requested content (text, highlights, summaries)."
        },
        "requestId": {
          "type": "string",
          "title": "Request Id",
          "description": "A unique identifier assigned to this specific API request."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "required": [
            "total"
          ],
          "properties": {
            "total": {
              "type": "number",
              "title": "Total",
              "description": "The total monetary cost for the entire request, in dollars."
            },
            "breakDown": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "CostDetail",
                "properties": {
                  "search": {
                    "type": "number",
                    "title": "Search",
                    "description": "Total cost related to search operations (e.g., keyword or neural)."
                  },
                  "contents": {
                    "type": "number",
                    "title": "Contents",
                    "description": "Total cost related to content retrieval operations (e.g., text, highlights, summary)."
                  },
                  "breakdown": {
                    "type": "object",
                    "title": "Breakdown",
                    "properties": {
                      "contentText": {
                        "type": "number",
                        "title": "Content Text",
                        "description": "Cost attributed to retrieving full text content for this request."
                      },
                      "neuralSearch": {
                        "type": "number",
                        "title": "Neural Search",
                        "description": "Cost attributed to neural search operations for this request."
                      },
                      "keywordSearch": {
                        "type": "number",
                        "title": "Keyword Search",
                        "description": "Cost attributed to keyword search operations for this request."
                      },
                      "contentSummary": {
                        "type": "number",
                        "title": "Content Summary",
                        "description": "Cost attributed to generating summaries for this request."
                      },
                      "contentHighlight": {
                        "type": "number",
                        "title": "Content Highlight",
                        "description": "Cost attributed to generating highlights for this request."
                      }
                    },
                    "description": "A detailed breakdown of costs by specific operation type."
                  }
                }
              },
              "title": "Break Down",
              "description": "A detailed breakdown of costs, categorizing them by the type of operation performed."
            },
            "perPagePrices": {
              "type": "object",
              "title": "Per Page Prices",
              "properties": {
                "contentText": {
                  "type": "number",
                  "title": "Content Text",
                  "description": "Standard price per page for retrieving full text content."
                },
                "contentSummary": {
                  "type": "number",
                  "title": "Content Summary",
                  "description": "Standard price per page for generating summaries."
                },
                "contentHighlight": {
                  "type": "number",
                  "title": "Content Highlight",
                  "description": "Standard price per page for generating highlights."
                }
              },
              "description": "Standard pricing details for various content retrieval operations on a per-page basis."
            },
            "perRequestPrices": {
              "type": "object",
              "title": "Per Request Prices",
              "properties": {
                "neuralSearch_1_25_results": {
                  "type": "number",
                  "title": "Neural Search 1 25 Results",
                  "description": "Standard price for a neural search operation returning 1-25 results."
                },
                "keywordSearch_1_100_results": {
                  "type": "number",
                  "title": "Keyword Search 1 100 Results",
                  "description": "Standard price for a keyword search operation returning 1-100 results."
                },
                "neuralSearch_26_100_results": {
                  "type": "number",
                  "title": "Neural Search 26 100 Results",
                  "description": "Standard price for a neural search operation returning 26-100 results."
                },
                "neuralSearch_100_plus_results": {
                  "type": "number",
                  "title": "Neural Search 100 Plus Results",
                  "description": "Standard price for a neural search operation returning 100+ results."
                },
                "keywordSearch_100_plus_results": {
                  "type": "number",
                  "title": "Keyword Search 100 Plus Results",
                  "description": "Standard price for a keyword search operation returning 100+ results."
                }
              },
              "description": "Standard pricing details for various search operations on a per-request basis."
            }
          },
          "description": "A detailed breakdown of the monetary costs associated with this request."
        }
      }
    }
  },
  "title": "FindSimilarResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "requestId",
        "results",
        "costDollars"
      ],
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Result",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "A unique temporary identifier for this search result document."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "The URL of the search result."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The full text content of the search result page. Populated if `text` was true in the request."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "The URL of an image associated with the search result, if available."
              },
              "score": {
                "type": "number",
                "title": "Score",
                "description": "A numerical score from 0 to 1 representing the semantic similarity between the input URL and this search result. Higher scores indicate greater similarity."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the search result."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "The author of the content, if available."
              },
              "extras": {
                "type": "object",
                "title": "Extras",
                "properties": {
                  "links": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Links",
                    "description": "A list of URLs for web links found within the content of the search result page."
                  }
                },
                "description": "Additional information or links extracted from the search result."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "The URL of the favicon for the search result's domain, if available."
              },
              "summary": {
                "type": "string",
                "title": "Summary",
                "description": "A generated summary of the search result page. Populated if `summary` was true in the request."
              },
              "subpages": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Subpages",
                "description": "An array of dictionaries, where each dictionary represents a subpage related to the main search result. The structure of these dictionaries may vary."
              },
              "highlights": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Highlights",
                "description": "A list of relevant text snippets extracted from the search result's content. Populated if `highlights` was true in the request."
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "An estimated creation date of the content, typically parsed from HTML."
              },
              "highlightScores": {
                "type": "array",
                "items": {
                  "type": "number"
                },
                "title": "Highlight Scores",
                "description": "A list of cosine similarity scores, corresponding to each snippet in the `highlights` array, indicating the relevance of each highlight."
              }
            }
          },
          "title": "Results",
          "description": "A list of `Result` objects, each detailing a web page found to be similar to the input URL. Contains metadata, similarity scores, and any additionally requested content (text, highlights, summaries)."
        },
        "requestId": {
          "type": "string",
          "title": "Request Id",
          "description": "A unique identifier assigned to this specific API request."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "required": [
            "total"
          ],
          "properties": {
            "total": {
              "type": "number",
              "title": "Total",
              "description": "The total monetary cost for the entire request, in dollars."
            },
            "breakDown": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "CostDetail",
                "properties": {
                  "search": {
                    "type": "number",
                    "title": "Search",
                    "description": "Total cost related to search operations (e.g., keyword or neural)."
                  },
                  "contents": {
                    "type": "number",
                    "title": "Contents",
                    "description": "Total cost related to content retrieval operations (e.g., text, highlights, summary)."
                  },
                  "breakdown": {
                    "type": "object",
                    "title": "Breakdown",
                    "properties": {
                      "contentText": {
                        "type": "number",
                        "title": "Content Text",
                        "description": "Cost attributed to retrieving full text content for this request."
                      },
                      "neuralSearch": {
                        "type": "number",
                        "title": "Neural Search",
                        "description": "Cost attributed to neural search operations for this request."
                      },
                      "keywordSearch": {
                        "type": "number",
                        "title": "Keyword Search",
                        "description": "Cost attributed to keyword search operations for this request."
                      },
                      "contentSummary": {
                        "type": "number",
                        "title": "Content Summary",
                        "description": "Cost attributed to generating summaries for this request."
                      },
                      "contentHighlight": {
                        "type": "number",
                        "title": "Content Highlight",
                        "description": "Cost attributed to generating highlights for this request."
                      }
                    },
                    "description": "A detailed breakdown of costs by specific operation type."
                  }
                }
              },
              "title": "Break Down",
              "description": "A detailed breakdown of costs, categorizing them by the type of operation performed."
            },
            "perPagePrices": {
              "type": "object",
              "title": "Per Page Prices",
              "properties": {
                "contentText": {
                  "type": "number",
                  "title": "Content Text",
                  "description": "Standard price per page for retrieving full text content."
                },
                "contentSummary": {
                  "type": "number",
                  "title": "Content Summary",
                  "description": "Standard price per page for generating summaries."
                },
                "contentHighlight": {
                  "type": "number",
                  "title": "Content Highlight",
                  "description": "Standard price per page for generating highlights."
                }
              },
              "description": "Standard pricing details for various content retrieval operations on a per-page basis."
            },
            "perRequestPrices": {
              "type": "object",
              "title": "Per Request Prices",
              "properties": {
                "neuralSearch_1_25_results": {
                  "type": "number",
                  "title": "Neural Search 1 25 Results",
                  "description": "Standard price for a neural search operation returning 1-25 results."
                },
                "keywordSearch_1_100_results": {
                  "type": "number",
                  "title": "Keyword Search 1 100 Results",
                  "description": "Standard price for a keyword search operation returning 1-100 results."
                },
                "neuralSearch_26_100_results": {
                  "type": "number",
                  "title": "Neural Search 26 100 Results",
                  "description": "Standard price for a neural search operation returning 26-100 results."
                },
                "neuralSearch_100_plus_results": {
                  "type": "number",
                  "title": "Neural Search 100 Plus Results",
                  "description": "Standard price for a neural search operation returning 100+ results."
                },
                "keywordSearch_100_plus_results": {
                  "type": "number",
                  "title": "Keyword Search 100 Plus Results",
                  "description": "Standard price for a keyword search operation returning 100+ results."
                }
              },
              "description": "Standard pricing details for various search operations on a per-request basis."
            }
          },
          "description": "A detailed breakdown of the monetary costs associated with this request."
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

## EXA_GET_API_KEY
Tool to retrieve details of a specific API key by its ID. Use when you need to fetch information about an API key in the team management context.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetApiKeyRequest",
  "required": [
    "apiKeyId"
  ],
  "properties": {
    "apiKeyId": {
      "type": "string",
      "title": "Api Key Id",
      "examples": [
        "f9678e86-e364-4a66-8d39-ff8b4232121a"
      ],
      "description": "The unique identifier of the API key to retrieve."
    }
  },
  "description": "Parameters to retrieve a specific API key by its ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "GetApiKeyResponse": {
      "type": "object",
      "title": "GetApiKeyResponse",
      "required": [
        "id",
        "createdAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier of the API key."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The name or label assigned to this API key."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the API key was created."
        },
        "rateLimit": {
          "type": "integer",
          "title": "Rate Limit",
          "description": "The rate limit associated with this API key."
        }
      },
      "description": "Response schema for retrieving an API key's details."
    }
  },
  "title": "GetApiKeyResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "createdAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier of the API key."
        },
        "name": {
          "type": "string",
          "title": "Name",
          "description": "The name or label assigned to this API key."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the API key was created."
        },
        "rateLimit": {
          "type": "integer",
          "title": "Rate Limit",
          "description": "The rate limit associated with this API key."
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

## EXA_GET_CONTENTS_ACTION
Retrieve text / highlights / summary / subpages from URLs. The endpoint returns HTTP 200 even when individual URLs fail — always inspect `statuses[]` for CRAWL_NOT_FOUND, CRAWL_LIVECRAWL_TIMEOUT, SOURCE_NOT_AVAILABLE. Control freshness with `maxAgeHours` (0 = always livecrawl, -1 = cache only). Use `subpages` + `subpageTarget` to crawl linked pages within a site in one request.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetContentsRequest",
  "properties": {
    "ids": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Ids",
      "examples": [
        "[\"https://arxiv.org/abs/2307.06435\"]"
      ],
      "description": "(Deprecated alias for 'urls') A list of document IDs or URLs. Use 'urls' parameter instead for consistency with the Exa API."
    },
    "text": {
      "anyOf": [
        {
          "type": "boolean"
        },
        {
          "type": "object",
          "title": "TextOptions",
          "properties": {
            "verbosity": {
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Verbosity",
              "default": null,
              "examples": [
                "compact",
                "standard",
                "full"
              ],
              "description": "Controls the level of detail in text extraction. Options: 'compact' (minimal text), 'standard' (balanced), 'full' (comprehensive). If not provided, API uses default behavior."
            },
            "maxCharacters": {
              "anyOf": [
                {
                  "type": "integer"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Maxcharacters",
              "default": null,
              "examples": [
                "1000",
                "5000",
                "None"
              ],
              "description": "Specifies the maximum number of characters for the extracted full-page text. If not provided or set to `None` (the default), no character limit is applied."
            },
            "excludeSections": {
              "anyOf": [
                {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                {
                  "type": "null"
                }
              ],
              "title": "Excludesections",
              "default": null,
              "examples": [
                [
                  "navigation",
                  "sidebar"
                ],
                [
                  "footer"
                ]
              ],
              "description": "List of HTML sections to exclude from text extraction. Options: 'header', 'navigation', 'banner', 'body', 'sidebar', 'footer', 'metadata'. If not provided, no sections are excluded."
            },
            "includeHtmlTags": {
              "anyOf": [
                {
                  "type": "boolean"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Includehtmltags",
              "default": null,
              "examples": [
                true,
                false
              ],
              "description": "If `True`, includes HTML tags in the extracted text, which can help LLMs understand the content's structure. If omitted, Exa defaults to `False`."
            },
            "includeSections": {
              "anyOf": [
                {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                {
                  "type": "null"
                }
              ],
              "title": "Includesections",
              "default": null,
              "examples": [
                [
                  "body",
                  "metadata"
                ],
                [
                  "header",
                  "body",
                  "footer"
                ]
              ],
              "description": "List of HTML sections to include in text extraction. Options: 'header', 'navigation', 'banner', 'body', 'sidebar', 'footer', 'metadata'. If not provided, all sections are included."
            }
          },
          "description": "Configuration for customizing text extraction from documents."
        }
      ],
      "title": "Text",
      "default": true,
      "description": "Controls text extraction. Accepts a boolean or a `TextOptions` object. If `True` (the default for this tool), sends Exa's documented `text=true` mode and extracts full-page text using default settings. If `False` or `None`, no text is extracted. Provide a `TextOptions` object to customize text extraction (e.g., `max_characters`, `include_html_tags`, `verbosity`)."
    },
    "urls": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Urls",
      "examples": [
        "[\"https://arxiv.org/abs/2307.06435\"]",
        "[\"exa_document_id_123\", \"https://example.com/another-article\"]"
      ],
      "description": "A list of fully qualified URLs (e.g., 'https://example.com/article') or document IDs (strings obtained from Exa search results) for which to retrieve content. At least one URL or ID must be provided."
    },
    "extras": {
      "type": "object",
      "title": "ExtrasOptions",
      "properties": {
        "links": {
          "type": "integer",
          "title": "Links",
          "default": 0,
          "examples": [
            "0",
            "5",
            "10"
          ],
          "description": "Number of links to extract from the document. Defaults to 0 (no links extracted)."
        },
        "imageLinks": {
          "type": "integer",
          "title": "Image Links",
          "default": 0,
          "examples": [
            "0",
            "3",
            "5"
          ],
          "description": "Number of image links to extract from the document. Defaults to 0 (no image links extracted)."
        }
      },
      "description": "Configuration for extracting additional metadata from documents.",
      "additionalProperties": false
    },
    "summary": {
      "anyOf": [
        {
          "type": "boolean"
        },
        {
          "type": "object",
          "title": "SummaryOptions",
          "properties": {
            "query": {
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Query",
              "default": null,
              "examples": [
                "What is the company?",
                "Key findings and conclusions"
              ],
              "description": "A specific query, topic, or question to guide the AI in generating the summary. If not provided, generates a general summary."
            },
            "schema": {
              "anyOf": [
                {
                  "type": "object",
                  "additionalProperties": true
                },
                {
                  "type": "null"
                }
              ],
              "title": "Schema",
              "default": null,
              "examples": [
                {
                  "type": "object",
                  "properties": {
                    "name": {
                      "type": "string"
                    }
                  }
                }
              ],
              "description": "JSON schema for structured summary output. Defines the shape of the returned summary data."
            }
          },
          "description": "Configuration for AI-generated summary extraction from documents."
        }
      ],
      "title": "Summary",
      "description": "Controls AI-generated summary extraction. Accepts a boolean or `SummaryOptions`. If `True`, generates a summary; if `False` or `None`, no summary. Use `SummaryOptions` for custom settings (e.g., `query`, `schema`)."
    },
    "subpages": {
      "type": "integer",
      "title": "Subpages",
      "default": 0,
      "examples": [
        "0",
        "3",
        "5",
        "8"
      ],
      "description": "Number of subpages to crawl per URL. Enables crawling linked pages within a site in one request. Defaults to 0 (no subpage crawling)."
    },
    "highlights": {
      "anyOf": [
        {
          "type": "boolean"
        },
        {
          "type": "object",
          "title": "HighlightOptions",
          "properties": {
            "query": {
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Query",
              "default": null,
              "examples": [
                "Key findings",
                "Main contributions",
                "None"
              ],
              "description": "A specific query, topic, or question to guide the AI in selecting the most relevant highlights from the document content. If not provided or set to `None` (the default), highlights are selected based on general relevance."
            },
            "maxCharacters": {
              "anyOf": [
                {
                  "type": "integer"
                },
                {
                  "type": "null"
                }
              ],
              "title": "Maxcharacters",
              "default": null,
              "examples": [
                "1000",
                "2000"
              ],
              "description": "Maximum number of characters for highlights. If not provided, API uses default behavior."
            }
          },
          "description": "Configuration for customizing AI-generated highlight extraction from documents."
        }
      ],
      "title": "Highlights",
      "description": "Controls highlight extraction. Accepts a boolean or `HighlightOptions`. If `True`, extracts AI highlights (default settings); if `False` or `None`, no highlights. Use `HighlightOptions` for custom settings (e.g., `query`, `max_characters`)."
    },
    "maxAgeHours": {
      "type": "integer",
      "title": "Max Age Hours",
      "examples": [
        "0",
        "24",
        "168",
        "-1"
      ],
      "description": "Controls content freshness. `0` = always livecrawl, `-1` = never livecrawl (cache only), `None` or positive integer = livecrawl as fallback if cached content is older than specified hours."
    },
    "subpageTarget": {
      "anyOf": [
        {
          "type": "string"
        },
        {
          "type": "array",
          "items": {
            "type": "string"
          }
        }
      ],
      "title": "Subpage Target",
      "examples": [
        "\"about\"",
        "[\"about\", \"careers\", \"press\"]"
      ],
      "description": "Keywords to prioritize for subpage selection when crawling subpages. Can be a single string or list of strings. Only relevant when `subpages` > 0."
    },
    "livecrawlTimeout": {
      "type": "integer",
      "title": "Livecrawl Timeout",
      "default": 10000,
      "examples": [
        "10000",
        "15000"
      ],
      "description": "Timeout in milliseconds for livecrawl operations. Recommended: 10000-15000 when forcing livecrawl. Defaults to 10000."
    }
  },
  "description": "Parameters for retrieving content from specified URLs or Exa document IDs."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ExtrasData": {
      "type": "object",
      "title": "ExtrasData",
      "properties": {
        "links": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Links",
          "description": "Extracted links from the document."
        },
        "imageLinks": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Image Links",
          "description": "Extracted image links from the document."
        }
      },
      "description": "Additional metadata extracted from documents."
    },
    "StatusError": {
      "type": "object",
      "title": "StatusError",
      "required": [
        "tag"
      ],
      "properties": {
        "tag": {
          "type": "string",
          "title": "Tag",
          "description": "Error tag identifying the failure type: CRAWL_NOT_FOUND, CRAWL_TIMEOUT, CRAWL_LIVECRAWL_TIMEOUT, SOURCE_NOT_AVAILABLE, UNSUPPORTED_URL, CRAWL_UNKNOWN_ERROR"
        },
        "httpStatusCode": {
          "type": "integer",
          "title": "Http Status Code",
          "description": "HTTP status code associated with the error, if applicable."
        }
      },
      "description": "Error details for a failed content retrieval."
    },
    "ContentStatus": {
      "type": "object",
      "title": "ContentStatus",
      "required": [
        "id",
        "status"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The URL or document ID from the request."
        },
        "error": {
          "type": "object",
          "title": "Error",
          "required": [
            "tag"
          ],
          "properties": {
            "tag": {
              "type": "string",
              "title": "Tag",
              "description": "Error tag identifying the failure type: CRAWL_NOT_FOUND, CRAWL_TIMEOUT, CRAWL_LIVECRAWL_TIMEOUT, SOURCE_NOT_AVAILABLE, UNSUPPORTED_URL, CRAWL_UNKNOWN_ERROR"
            },
            "httpStatusCode": {
              "type": "integer",
              "title": "Http Status Code",
              "description": "HTTP status code associated with the error, if applicable."
            }
          },
          "description": "Error details if status is 'error'. The endpoint returns HTTP 200 even on per-URL failure \u2014 this is the only failure signal."
        },
        "source": {
          "type": "string",
          "title": "Source",
          "description": "Source of the content: 'cached' or 'livecrawl'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of content retrieval: 'success' or 'error'."
        }
      },
      "description": "Status information for a single URL/ID in the request."
    },
    "ContentResultItem": {
      "type": "object",
      "title": "ContentResultItem",
      "required": [
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique ID of the document or the URL provided in the request."
        },
        "url": {
          "type": "string",
          "title": "Url",
          "format": "uri",
          "maxLength": 2083,
          "minLength": 1,
          "description": "The canonical URL of the document, if available."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The extracted text content of the document, if requested. With `text=true`, responses can be very large; set `maxCharacters` in a `TextOptions` object to cap length and prevent token overflow. Extracted text may include navigation boilerplate, flattened tables, and duplicate content \u2014 plan for post-processing."
        },
        "image": {
          "type": "string",
          "title": "Image",
          "description": "URL of the main image for the document, if available."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the document."
        },
        "author": {
          "type": "string",
          "title": "Author",
          "description": "The author of the document, if available."
        },
        "extras": {
          "type": "object",
          "title": "Extras",
          "properties": {
            "links": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Links",
              "description": "Extracted links from the document."
            },
            "imageLinks": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Image Links",
              "description": "Extracted image links from the document."
            }
          },
          "description": "Additional metadata such as links and image links, if requested."
        },
        "favicon": {
          "type": "string",
          "title": "Favicon",
          "description": "URL of the favicon for the document's site, if available."
        },
        "summary": {
          "type": "string",
          "title": "Summary",
          "description": "AI-generated summary of the document, if requested."
        },
        "subpages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentResultItem",
            "required": [
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique ID of the document or the URL provided in the request."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "The canonical URL of the document, if available."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The extracted text content of the document, if requested. With `text=true`, responses can be very large; set `maxCharacters` in a `TextOptions` object to cap length and prevent token overflow. Extracted text may include navigation boilerplate, flattened tables, and duplicate content \u2014 plan for post-processing."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "URL of the main image for the document, if available."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the document."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "The author of the document, if available."
              },
              "extras": {
                "type": "object",
                "title": "Extras",
                "properties": {
                  "links": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Links",
                    "description": "Extracted links from the document."
                  },
                  "imageLinks": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Image Links",
                    "description": "Extracted image links from the document."
                  }
                },
                "description": "Additional metadata such as links and image links, if requested."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "URL of the favicon for the document's site, if available."
              },
              "summary": {
                "type": "string",
                "title": "Summary",
                "description": "AI-generated summary of the document, if requested."
              },
              "subpages": {
                "type": "array",
                "items": {
                  "$ref": "#/$defs/ContentResultItem"
                },
                "title": "Subpages",
                "description": "Nested results from subpage crawl, if requested. Each subpage has the same structure as a top-level result."
              },
              "highlights": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Highlights",
                "description": "A list of AI-generated highlight snippets from the document content, if requested. Prefer `highlights` with `text=false` when only key passages are needed, to reduce payload size and cost."
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "The publication date of the document (e.g., YYYY-MM-DD)."
              }
            }
          },
          "title": "Subpages",
          "description": "Nested results from subpage crawl, if requested. Each subpage has the same structure as a top-level result."
        },
        "highlights": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Highlights",
          "description": "A list of AI-generated highlight snippets from the document content, if requested. Prefer `highlights` with `text=false` when only key passages are needed, to reduce payload size and cost."
        },
        "publishedDate": {
          "type": "string",
          "title": "Published Date",
          "description": "The publication date of the document (e.g., YYYY-MM-DD)."
        }
      }
    },
    "GetContentsResponse": {
      "type": "object",
      "title": "GetContentsResponse",
      "required": [
        "results",
        "statuses",
        "requestId",
        "costDollars"
      ],
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentResultItem",
            "required": [
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique ID of the document or the URL provided in the request."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "The canonical URL of the document, if available."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The extracted text content of the document, if requested. With `text=true`, responses can be very large; set `maxCharacters` in a `TextOptions` object to cap length and prevent token overflow. Extracted text may include navigation boilerplate, flattened tables, and duplicate content \u2014 plan for post-processing."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "URL of the main image for the document, if available."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the document."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "The author of the document, if available."
              },
              "extras": {
                "type": "object",
                "title": "Extras",
                "properties": {
                  "links": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Links",
                    "description": "Extracted links from the document."
                  },
                  "imageLinks": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Image Links",
                    "description": "Extracted image links from the document."
                  }
                },
                "description": "Additional metadata such as links and image links, if requested."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "URL of the favicon for the document's site, if available."
              },
              "summary": {
                "type": "string",
                "title": "Summary",
                "description": "AI-generated summary of the document, if requested."
              },
              "subpages": {
                "type": "array",
                "items": {
                  "$ref": "#/$defs/ContentResultItem"
                },
                "title": "Subpages",
                "description": "Nested results from subpage crawl, if requested. Each subpage has the same structure as a top-level result."
              },
              "highlights": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Highlights",
                "description": "A list of AI-generated highlight snippets from the document content, if requested. Prefer `highlights` with `text=false` when only key passages are needed, to reduce payload size and cost."
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "The publication date of the document (e.g., YYYY-MM-DD)."
              }
            }
          },
          "title": "Results",
          "description": "A list of ContentResultItem objects, one for each successfully processed document ID or URL from the request. Each item provides detailed content and metadata for a document."
        },
        "statuses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentStatus",
            "required": [
              "id",
              "status"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The URL or document ID from the request."
              },
              "error": {
                "type": "object",
                "title": "Error",
                "required": [
                  "tag"
                ],
                "properties": {
                  "tag": {
                    "type": "string",
                    "title": "Tag",
                    "description": "Error tag identifying the failure type: CRAWL_NOT_FOUND, CRAWL_TIMEOUT, CRAWL_LIVECRAWL_TIMEOUT, SOURCE_NOT_AVAILABLE, UNSUPPORTED_URL, CRAWL_UNKNOWN_ERROR"
                  },
                  "httpStatusCode": {
                    "type": "integer",
                    "title": "Http Status Code",
                    "description": "HTTP status code associated with the error, if applicable."
                  }
                },
                "description": "Error details if status is 'error'. The endpoint returns HTTP 200 even on per-URL failure \u2014 this is the only failure signal."
              },
              "source": {
                "type": "string",
                "title": "Source",
                "description": "Source of the content: 'cached' or 'livecrawl'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of content retrieval: 'success' or 'error'."
              }
            },
            "description": "Status information for a single URL/ID in the request."
          },
          "title": "Statuses",
          "description": "Status information for each requested URL. CRITICAL: The endpoint returns HTTP 200 even when individual URLs fail \u2014 always inspect this array for errors like CRAWL_NOT_FOUND, CRAWL_LIVECRAWL_TIMEOUT, SOURCE_NOT_AVAILABLE, UNSUPPORTED_URL."
        },
        "requestId": {
          "type": "string",
          "title": "Request Id",
          "description": "A unique string identifier assigned by the Exa service to this specific API request instance, useful for logging and support."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "description": "A dictionary providing details about the monetary cost incurred for processing the API request. Structure may vary.",
          "additionalProperties": true
        }
      },
      "description": "Response containing document contents, including extracted text, highlights, and metadata."
    }
  },
  "title": "GetContentsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "results",
        "statuses",
        "requestId",
        "costDollars"
      ],
      "properties": {
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentResultItem",
            "required": [
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique ID of the document or the URL provided in the request."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "format": "uri",
                "maxLength": 2083,
                "minLength": 1,
                "description": "The canonical URL of the document, if available."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "The extracted text content of the document, if requested. With `text=true`, responses can be very large; set `maxCharacters` in a `TextOptions` object to cap length and prevent token overflow. Extracted text may include navigation boilerplate, flattened tables, and duplicate content \u2014 plan for post-processing."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "URL of the main image for the document, if available."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the document."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "The author of the document, if available."
              },
              "extras": {
                "type": "object",
                "title": "Extras",
                "properties": {
                  "links": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Links",
                    "description": "Extracted links from the document."
                  },
                  "imageLinks": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Image Links",
                    "description": "Extracted image links from the document."
                  }
                },
                "description": "Additional metadata such as links and image links, if requested."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "URL of the favicon for the document's site, if available."
              },
              "summary": {
                "type": "string",
                "title": "Summary",
                "description": "AI-generated summary of the document, if requested."
              },
              "subpages": {
                "type": "array",
                "items": {
                  "$ref": "#/$defs/ContentResultItem"
                },
                "title": "Subpages",
                "description": "Nested results from subpage crawl, if requested. Each subpage has the same structure as a top-level result."
              },
              "highlights": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Highlights",
                "description": "A list of AI-generated highlight snippets from the document content, if requested. Prefer `highlights` with `text=false` when only key passages are needed, to reduce payload size and cost."
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "The publication date of the document (e.g., YYYY-MM-DD)."
              }
            }
          },
          "title": "Results",
          "description": "A list of ContentResultItem objects, one for each successfully processed document ID or URL from the request. Each item provides detailed content and metadata for a document."
        },
        "statuses": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ContentStatus",
            "required": [
              "id",
              "status"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The URL or document ID from the request."
              },
              "error": {
                "type": "object",
                "title": "Error",
                "required": [
                  "tag"
                ],
                "properties": {
                  "tag": {
                    "type": "string",
                    "title": "Tag",
                    "description": "Error tag identifying the failure type: CRAWL_NOT_FOUND, CRAWL_TIMEOUT, CRAWL_LIVECRAWL_TIMEOUT, SOURCE_NOT_AVAILABLE, UNSUPPORTED_URL, CRAWL_UNKNOWN_ERROR"
                  },
                  "httpStatusCode": {
                    "type": "integer",
                    "title": "Http Status Code",
                    "description": "HTTP status code associated with the error, if applicable."
                  }
                },
                "description": "Error details if status is 'error'. The endpoint returns HTTP 200 even on per-URL failure \u2014 this is the only failure signal."
              },
              "source": {
                "type": "string",
                "title": "Source",
                "description": "Source of the content: 'cached' or 'livecrawl'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Status of content retrieval: 'success' or 'error'."
              }
            },
            "description": "Status information for a single URL/ID in the request."
          },
          "title": "Statuses",
          "description": "Status information for each requested URL. CRITICAL: The endpoint returns HTTP 200 even when individual URLs fail \u2014 always inspect this array for errors like CRAWL_NOT_FOUND, CRAWL_LIVECRAWL_TIMEOUT, SOURCE_NOT_AVAILABLE, UNSUPPORTED_URL."
        },
        "requestId": {
          "type": "string",
          "title": "Request Id",
          "description": "A unique string identifier assigned by the Exa service to this specific API request instance, useful for logging and support."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "description": "A dictionary providing details about the monetary cost incurred for processing the API request. Structure may vary.",
          "additionalProperties": true
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

## EXA_GET_EVENT
Tool to get details of a specific event by its ID. Use when you have an event ID and need its full details.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetEventRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "evt_123456"
      ],
      "description": "The unique identifier of the event to retrieve."
    }
  },
  "description": "Parameters to retrieve a specific Exa Event by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "object",
        "status",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the object that triggered the event (webset, import, monitor, etc.)."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Display name or title of the object. Nullable."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Object type (e.g., 'webset', 'import', 'monitor')."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the object. Values include: idle, pending, running, paused, created, completed, canceled, failed."
        },
        "imports": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImportItem",
            "required": [
              "id",
              "object",
              "status",
              "format",
              "entity",
              "title",
              "count",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the import."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Number of items imported."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the import."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "description": "Entity type classification for imported data.",
                "additionalProperties": true
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "Format of the imported data (e.g., 'csv', 'webset')."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "Object type, always 'import'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Current status of the import."
              },
              "failedAt": {
                "type": "string",
                "title": "Failed At",
                "description": "Timestamp when the import failed. Nullable."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Custom key-value pairs (max 1000 characters per value).",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "ISO 8601 timestamp when the import was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "ISO 8601 timestamp when the import was last updated."
              },
              "failedReason": {
                "type": "string",
                "title": "Failed Reason",
                "description": "Reason for import failure. Nullable."
              },
              "failedMessage": {
                "type": "string",
                "title": "Failed Message",
                "description": "Detailed error message for import failure. Nullable."
              }
            }
          },
          "title": "Imports",
          "description": "Array of import operations for uploading data into websets."
        },
        "excludes": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Exclude",
            "required": [
              "source",
              "id"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "ID of the exclusion source."
              },
              "source": {
                "type": "string",
                "title": "Source",
                "description": "Source type for exclusion (e.g., 'import', 'webset')."
              }
            }
          },
          "title": "Excludes",
          "description": "Global exclusion sources applied across all operations."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Custom key-value pairs for storing additional information (max 1000 characters per value).",
          "additionalProperties": true
        },
        "monitors": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Monitor",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "cadence",
              "behavior",
              "lastRun",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the monitor."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "Object type, always 'monitor'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Current status of the monitor."
              },
              "cadence": {
                "type": "object",
                "title": "Cadence",
                "required": [
                  "cron",
                  "timezone"
                ],
                "properties": {
                  "cron": {
                    "type": "string",
                    "title": "Cron",
                    "description": "Cron expression defining the schedule."
                  },
                  "timezone": {
                    "type": "string",
                    "title": "Timezone",
                    "description": "Timezone for the schedule."
                  }
                },
                "description": "Scheduling configuration for the monitor."
              },
              "lastRun": {
                "type": "object",
                "title": "Last Run",
                "required": [
                  "status"
                ],
                "properties": {
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Status of the last run."
                  },
                  "startedAt": {
                    "type": "string",
                    "title": "Started At",
                    "description": "Timestamp when the run started."
                  },
                  "completedAt": {
                    "type": "string",
                    "title": "Completed At",
                    "description": "Timestamp when the run completed."
                  }
                },
                "description": "Information about the most recent monitor execution."
              },
              "behavior": {
                "type": "object",
                "title": "Behavior",
                "required": [
                  "type"
                ],
                "properties": {
                  "type": {
                    "type": "string",
                    "title": "Type",
                    "description": "Behavior type, typically 'search'."
                  },
                  "config": {
                    "type": "object",
                    "title": "Config",
                    "description": "Configuration parameters for the behavior.",
                    "additionalProperties": true
                  }
                },
                "description": "Monitor behavior configuration."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Custom key-value pairs (max 1000 characters per value).",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "ID of the parent webset."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "ISO 8601 timestamp when the monitor was created."
              },
              "nextRunAt": {
                "type": "string",
                "title": "Next Run At",
                "description": "ISO 8601 timestamp of the next scheduled execution. Nullable."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "ISO 8601 timestamp when the monitor was last updated."
              }
            }
          },
          "title": "Monitors",
          "description": "Array of monitors that continuously keep websets updated with fresh data through scheduled operations."
        },
        "searches": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SearchItem",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "query",
              "entity",
              "criteria",
              "count",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the search."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Target number of results to find."
              },
              "query": {
                "type": "string",
                "title": "Query",
                "description": "Search query string."
              },
              "scope": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Scope",
                "description": "Search scope boundaries with relationship definitions."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "description": "Entity type configuration for the search (e.g., company, person, article, research-paper, custom).",
                "additionalProperties": true
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "Object type, always 'webset_search'."
              },
              "recall": {
                "type": "object",
                "title": "Recall",
                "required": [
                  "expected",
                  "reasoning"
                ],
                "properties": {
                  "expected": {
                    "type": "object",
                    "title": "Expected",
                    "required": [
                      "total",
                      "confidence",
                      "bounds"
                    ],
                    "properties": {
                      "total": {
                        "type": "integer",
                        "title": "Total",
                        "description": "Expected total number of results."
                      },
                      "bounds": {
                        "type": "object",
                        "title": "Bounds",
                        "required": [
                          "min",
                          "max"
                        ],
                        "properties": {
                          "max": {
                            "type": "integer",
                            "title": "Max",
                            "description": "Maximum bound value."
                          },
                          "min": {
                            "type": "integer",
                            "title": "Min",
                            "description": "Minimum bound value."
                          }
                        },
                        "description": "Bounds of the expected results."
                      },
                      "confidence": {
                        "type": "string",
                        "title": "Confidence",
                        "description": "Confidence level of the expectation."
                      }
                    },
                    "description": "Details of expected recall metrics."
                  },
                  "reasoning": {
                    "type": "string",
                    "title": "Reasoning",
                    "description": "Reasoning behind recall estimates."
                  }
                },
                "description": "Expected total results with confidence levels."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Current status of the search."
              },
              "exclude": {
                "type": "array",
                "items": {
                  "type": "object",
                  "additionalProperties": true
                },
                "title": "Exclude",
                "description": "Array of sources to exclude from search results."
              },
              "behavior": {
                "type": "string",
                "title": "Behavior",
                "description": "Search behavior mode: 'override' or 'append'."
              },
              "criteria": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Criteria",
                  "required": [
                    "description",
                    "successRate"
                  ],
                  "properties": {
                    "description": {
                      "type": "string",
                      "title": "Description",
                      "description": "Description of the criterion."
                    },
                    "successRate": {
                      "type": "number",
                      "title": "Success Rate",
                      "description": "Success rate threshold (0-100)."
                    }
                  }
                },
                "title": "Criteria",
                "description": "Evaluation criteria for matching results."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Custom key-value pairs (max 1000 characters per value).",
                "additionalProperties": true
              },
              "progress": {
                "type": "object",
                "title": "Progress",
                "properties": {
                  "found": {
                    "type": "integer",
                    "title": "Found",
                    "description": "Number of results found so far."
                  },
                  "analyzed": {
                    "type": "integer",
                    "title": "Analyzed",
                    "description": "Number of pages analyzed."
                  },
                  "timeLeft": {
                    "type": "string",
                    "title": "Time Left",
                    "description": "Estimated time remaining."
                  },
                  "completion": {
                    "type": "number",
                    "title": "Completion",
                    "description": "Completion percentage."
                  }
                },
                "description": "Search progress information."
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "ID of the parent webset."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "ISO 8601 timestamp when the search was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "ISO 8601 timestamp when the search was last updated."
              },
              "canceledAt": {
                "type": "string",
                "title": "Canceled At",
                "description": "Timestamp when the search was canceled."
              },
              "canceledReason": {
                "type": "string",
                "title": "Canceled Reason",
                "description": "Reason for search cancellation."
              }
            }
          },
          "title": "Searches",
          "description": "Array of search operations associated with the webset."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the object was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp when the object was last updated."
        },
        "externalId": {
          "type": "string",
          "title": "External Id",
          "description": "Your internal identifier for the object. Nullable."
        },
        "enrichments": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Enrichment",
            "required": [
              "id",
              "object",
              "status",
              "websetId",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the enrichment."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the enrichment. Nullable."
              },
              "format": {
                "type": "string",
                "title": "Format",
                "description": "Format of enriched data (e.g., text, date, number, options, email, phone, url). Nullable."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "Object type, always 'webset_enrichment'."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Current status of the enrichment."
              },
              "options": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "Option",
                  "required": [
                    "label"
                  ],
                  "properties": {
                    "label": {
                      "type": "string",
                      "title": "Label",
                      "description": "Label of the enrichment option."
                    }
                  }
                },
                "title": "Options",
                "description": "Available options when format is 'options'. Nullable."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Custom key-value pairs (max 1000 characters per value).",
                "additionalProperties": true
              },
              "websetId": {
                "type": "string",
                "title": "Webset Id",
                "description": "ID of the parent webset."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "ISO 8601 timestamp when the enrichment was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "ISO 8601 timestamp when the enrichment was last updated."
              },
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of what data the enrichment extracts. Nullable."
              },
              "instructions": {
                "type": "string",
                "title": "Instructions",
                "description": "Agent instructions for the enrichment task. Nullable."
              }
            }
          },
          "title": "Enrichments",
          "description": "Array of enrichment tasks that enhance webset items with additional structured data."
        }
      }
    },
    "Bounds": {
      "type": "object",
      "title": "Bounds",
      "required": [
        "min",
        "max"
      ],
      "properties": {
        "max": {
          "type": "integer",
          "title": "Max",
          "description": "Maximum bound value."
        },
        "min": {
          "type": "integer",
          "title": "Min",
          "description": "Minimum bound value."
        }
      }
    },
    "Option": {
      "type": "object",
      "title": "Option",
      "required": [
        "label"
      ],
      "properties": {
        "label": {
          "type": "string",
          "title": "Label",
          "description": "Label of the enrichment option."
        }
      }
    },
    "Recall": {
      "type": "object",
      "title": "Recall",
      "required": [
        "expected",
        "reasoning"
      ],
      "properties": {
        "expected": {
          "type": "object",
          "title": "Expected",
          "required": [
            "total",
            "confidence",
            "bounds"
          ],
          "properties": {
            "total": {
              "type": "integer",
              "title": "Total",
              "description": "Expected total number of results."
            },
            "bounds": {
              "type": "object",
              "title": "Bounds",
              "required": [
                "min",
                "max"
              ],
              "properties": {
                "max": {
                  "type": "integer",
                  "title": "Max",
                  "description": "Maximum bound value."
                },
                "min": {
                  "type": "integer",
                  "title": "Min",
                  "description": "Minimum bound value."
                }
              },
              "description": "Bounds of the expected results."
            },
            "confidence": {
              "type": "string",
              "title": "Confidence",
              "description": "Confidence level of the expectation."
            }
          },
          "description": "Details of expected recall metrics."
        },
        "reasoning": {
          "type": "string",
          "title": "Reasoning",
          "description": "Reasoning behind recall estimates."
        }
      }
    },
    "Cadence": {
      "type": "object",
      "title": "Cadence",
      "required": [
        "cron",
        "timezone"
      ],
      "properties": {
        "cron": {
          "type": "string",
          "title": "Cron",
          "description": "Cron expression defining the schedule."
        },
        "timezone": {
          "type": "string",
          "title": "Timezone",
          "description": "Timezone for the schedule."
        }
      }
    },
    "Exclude": {
      "type": "object",
      "title": "Exclude",
      "required": [
        "source",
        "id"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "ID of the exclusion source."
        },
        "source": {
          "type": "string",
          "title": "Source",
          "description": "Source type for exclusion (e.g., 'import', 'webset')."
        }
      }
    },
    "Monitor": {
      "type": "object",
      "title": "Monitor",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "cadence",
        "behavior",
        "lastRun",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the monitor."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Object type, always 'monitor'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the monitor."
        },
        "cadence": {
          "type": "object",
          "title": "Cadence",
          "required": [
            "cron",
            "timezone"
          ],
          "properties": {
            "cron": {
              "type": "string",
              "title": "Cron",
              "description": "Cron expression defining the schedule."
            },
            "timezone": {
              "type": "string",
              "title": "Timezone",
              "description": "Timezone for the schedule."
            }
          },
          "description": "Scheduling configuration for the monitor."
        },
        "lastRun": {
          "type": "object",
          "title": "Last Run",
          "required": [
            "status"
          ],
          "properties": {
            "status": {
              "type": "string",
              "title": "Status",
              "description": "Status of the last run."
            },
            "startedAt": {
              "type": "string",
              "title": "Started At",
              "description": "Timestamp when the run started."
            },
            "completedAt": {
              "type": "string",
              "title": "Completed At",
              "description": "Timestamp when the run completed."
            }
          },
          "description": "Information about the most recent monitor execution."
        },
        "behavior": {
          "type": "object",
          "title": "Behavior",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "Behavior type, typically 'search'."
            },
            "config": {
              "type": "object",
              "title": "Config",
              "description": "Configuration parameters for the behavior.",
              "additionalProperties": true
            }
          },
          "description": "Monitor behavior configuration."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Custom key-value pairs (max 1000 characters per value).",
          "additionalProperties": true
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "ID of the parent webset."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the monitor was created."
        },
        "nextRunAt": {
          "type": "string",
          "title": "Next Run At",
          "description": "ISO 8601 timestamp of the next scheduled execution. Nullable."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp when the monitor was last updated."
        }
      }
    },
    "Criteria": {
      "type": "object",
      "title": "Criteria",
      "required": [
        "description",
        "successRate"
      ],
      "properties": {
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of the criterion."
        },
        "successRate": {
          "type": "number",
          "title": "Success Rate",
          "description": "Success rate threshold (0-100)."
        }
      }
    },
    "Expected": {
      "type": "object",
      "title": "Expected",
      "required": [
        "total",
        "confidence",
        "bounds"
      ],
      "properties": {
        "total": {
          "type": "integer",
          "title": "Total",
          "description": "Expected total number of results."
        },
        "bounds": {
          "type": "object",
          "title": "Bounds",
          "required": [
            "min",
            "max"
          ],
          "properties": {
            "max": {
              "type": "integer",
              "title": "Max",
              "description": "Maximum bound value."
            },
            "min": {
              "type": "integer",
              "title": "Min",
              "description": "Minimum bound value."
            }
          },
          "description": "Bounds of the expected results."
        },
        "confidence": {
          "type": "string",
          "title": "Confidence",
          "description": "Confidence level of the expectation."
        }
      }
    },
    "Progress": {
      "type": "object",
      "title": "Progress",
      "properties": {
        "found": {
          "type": "integer",
          "title": "Found",
          "description": "Number of results found so far."
        },
        "analyzed": {
          "type": "integer",
          "title": "Analyzed",
          "description": "Number of pages analyzed."
        },
        "timeLeft": {
          "type": "string",
          "title": "Time Left",
          "description": "Estimated time remaining."
        },
        "completion": {
          "type": "number",
          "title": "Completion",
          "description": "Completion percentage."
        }
      }
    },
    "Enrichment": {
      "type": "object",
      "title": "Enrichment",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the enrichment."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the enrichment. Nullable."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "Format of enriched data (e.g., text, date, number, options, email, phone, url). Nullable."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Object type, always 'webset_enrichment'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the enrichment."
        },
        "options": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Option",
            "required": [
              "label"
            ],
            "properties": {
              "label": {
                "type": "string",
                "title": "Label",
                "description": "Label of the enrichment option."
              }
            }
          },
          "title": "Options",
          "description": "Available options when format is 'options'. Nullable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Custom key-value pairs (max 1000 characters per value).",
          "additionalProperties": true
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "ID of the parent webset."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the enrichment was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp when the enrichment was last updated."
        },
        "description": {
          "type": "string",
          "title": "Description",
          "description": "Description of what data the enrichment extracts. Nullable."
        },
        "instructions": {
          "type": "string",
          "title": "Instructions",
          "description": "Agent instructions for the enrichment task. Nullable."
        }
      }
    },
    "ImportItem": {
      "type": "object",
      "title": "ImportItem",
      "required": [
        "id",
        "object",
        "status",
        "format",
        "entity",
        "title",
        "count",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of items imported."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "description": "Entity type classification for imported data.",
          "additionalProperties": true
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "Format of the imported data (e.g., 'csv', 'webset')."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Object type, always 'import'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the import."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the import failed. Nullable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Custom key-value pairs (max 1000 characters per value).",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp when the import was last updated."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason for import failure. Nullable."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "Detailed error message for import failure. Nullable."
        }
      }
    },
    "SearchItem": {
      "type": "object",
      "title": "SearchItem",
      "required": [
        "id",
        "object",
        "status",
        "websetId",
        "query",
        "entity",
        "criteria",
        "count",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the search."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Target number of results to find."
        },
        "query": {
          "type": "string",
          "title": "Query",
          "description": "Search query string."
        },
        "scope": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Scope",
          "description": "Search scope boundaries with relationship definitions."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "description": "Entity type configuration for the search (e.g., company, person, article, research-paper, custom).",
          "additionalProperties": true
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Object type, always 'webset_search'."
        },
        "recall": {
          "type": "object",
          "title": "Recall",
          "required": [
            "expected",
            "reasoning"
          ],
          "properties": {
            "expected": {
              "type": "object",
              "title": "Expected",
              "required": [
                "total",
                "confidence",
                "bounds"
              ],
              "properties": {
                "total": {
                  "type": "integer",
                  "title": "Total",
                  "description": "Expected total number of results."
                },
                "bounds": {
                  "type": "object",
                  "title": "Bounds",
                  "required": [
                    "min",
                    "max"
                  ],
                  "properties": {
                    "max": {
                      "type": "integer",
                      "title": "Max",
                      "description": "Maximum bound value."
                    },
                    "min": {
                      "type": "integer",
                      "title": "Min",
                      "description": "Minimum bound value."
                    }
                  },
                  "description": "Bounds of the expected results."
                },
                "confidence": {
                  "type": "string",
                  "title": "Confidence",
                  "description": "Confidence level of the expectation."
                }
              },
              "description": "Details of expected recall metrics."
            },
            "reasoning": {
              "type": "string",
              "title": "Reasoning",
              "description": "Reasoning behind recall estimates."
            }
          },
          "description": "Expected total results with confidence levels."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the search."
        },
        "exclude": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Exclude",
          "description": "Array of sources to exclude from search results."
        },
        "behavior": {
          "type": "string",
          "title": "Behavior",
          "description": "Search behavior mode: 'override' or 'append'."
        },
        "criteria": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Criteria",
            "required": [
              "description",
              "successRate"
            ],
            "properties": {
              "description": {
                "type": "string",
                "title": "Description",
                "description": "Description of the criterion."
              },
              "successRate": {
                "type": "number",
                "title": "Success Rate",
                "description": "Success rate threshold (0-100)."
              }
            }
          },
          "title": "Criteria",
          "description": "Evaluation criteria for matching results."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Custom key-value pairs (max 1000 characters per value).",
          "additionalProperties": true
        },
        "progress": {
          "type": "object",
          "title": "Progress",
          "properties": {
            "found": {
              "type": "integer",
              "title": "Found",
              "description": "Number of results found so far."
            },
            "analyzed": {
              "type": "integer",
              "title": "Analyzed",
              "description": "Number of pages analyzed."
            },
            "timeLeft": {
              "type": "string",
              "title": "Time Left",
              "description": "Estimated time remaining."
            },
            "completion": {
              "type": "number",
              "title": "Completion",
              "description": "Completion percentage."
            }
          },
          "description": "Search progress information."
        },
        "websetId": {
          "type": "string",
          "title": "Webset Id",
          "description": "ID of the parent webset."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the search was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO 8601 timestamp when the search was last updated."
        },
        "canceledAt": {
          "type": "string",
          "title": "Canceled At",
          "description": "Timestamp when the search was canceled."
        },
        "canceledReason": {
          "type": "string",
          "title": "Canceled Reason",
          "description": "Reason for search cancellation."
        }
      }
    },
    "MonitorLastRun": {
      "type": "object",
      "title": "MonitorLastRun",
      "required": [
        "status"
      ],
      "properties": {
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Status of the last run."
        },
        "startedAt": {
          "type": "string",
          "title": "Started At",
          "description": "Timestamp when the run started."
        },
        "completedAt": {
          "type": "string",
          "title": "Completed At",
          "description": "Timestamp when the run completed."
        }
      }
    },
    "MonitorBehavior": {
      "type": "object",
      "title": "MonitorBehavior",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Behavior type, typically 'search'."
        },
        "config": {
          "type": "object",
          "title": "Config",
          "description": "Configuration parameters for the behavior.",
          "additionalProperties": true
        }
      }
    },
    "GetEventResponse": {
      "type": "object",
      "title": "GetEventResponse",
      "required": [
        "id",
        "object",
        "type",
        "data",
        "createdAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the event."
        },
        "data": {
          "type": "object",
          "title": "Data",
          "required": [
            "id",
            "object",
            "status",
            "createdAt",
            "updatedAt"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier for the object that triggered the event (webset, import, monitor, etc.)."
            },
            "title": {
              "type": "string",
              "title": "Title",
              "description": "Display name or title of the object. Nullable."
            },
            "object": {
              "type": "string",
              "title": "Object",
              "description": "Object type (e.g., 'webset', 'import', 'monitor')."
            },
            "status": {
              "type": "string",
              "title": "Status",
              "description": "Current status of the object. Values include: idle, pending, running, paused, created, completed, canceled, failed."
            },
            "imports": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "ImportItem",
                "required": [
                  "id",
                  "object",
                  "status",
                  "format",
                  "entity",
                  "title",
                  "count",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the import."
                  },
                  "count": {
                    "type": "integer",
                    "title": "Count",
                    "description": "Number of items imported."
                  },
                  "title": {
                    "type": "string",
                    "title": "Title",
                    "description": "Title of the import."
                  },
                  "entity": {
                    "type": "object",
                    "title": "Entity",
                    "description": "Entity type classification for imported data.",
                    "additionalProperties": true
                  },
                  "format": {
                    "type": "string",
                    "title": "Format",
                    "description": "Format of the imported data (e.g., 'csv', 'webset')."
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "Object type, always 'import'."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Current status of the import."
                  },
                  "failedAt": {
                    "type": "string",
                    "title": "Failed At",
                    "description": "Timestamp when the import failed. Nullable."
                  },
                  "metadata": {
                    "type": "object",
                    "title": "Metadata",
                    "description": "Custom key-value pairs (max 1000 characters per value).",
                    "additionalProperties": true
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "ISO 8601 timestamp when the import was created."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "ISO 8601 timestamp when the import was last updated."
                  },
                  "failedReason": {
                    "type": "string",
                    "title": "Failed Reason",
                    "description": "Reason for import failure. Nullable."
                  },
                  "failedMessage": {
                    "type": "string",
                    "title": "Failed Message",
                    "description": "Detailed error message for import failure. Nullable."
                  }
                }
              },
              "title": "Imports",
              "description": "Array of import operations for uploading data into websets."
            },
            "excludes": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Exclude",
                "required": [
                  "source",
                  "id"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "ID of the exclusion source."
                  },
                  "source": {
                    "type": "string",
                    "title": "Source",
                    "description": "Source type for exclusion (e.g., 'import', 'webset')."
                  }
                }
              },
              "title": "Excludes",
              "description": "Global exclusion sources applied across all operations."
            },
            "metadata": {
              "type": "object",
              "title": "Metadata",
              "description": "Custom key-value pairs for storing additional information (max 1000 characters per value).",
              "additionalProperties": true
            },
            "monitors": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Monitor",
                "required": [
                  "id",
                  "object",
                  "status",
                  "websetId",
                  "cadence",
                  "behavior",
                  "lastRun",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the monitor."
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "Object type, always 'monitor'."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Current status of the monitor."
                  },
                  "cadence": {
                    "type": "object",
                    "title": "Cadence",
                    "required": [
                      "cron",
                      "timezone"
                    ],
                    "properties": {
                      "cron": {
                        "type": "string",
                        "title": "Cron",
                        "description": "Cron expression defining the schedule."
                      },
                      "timezone": {
                        "type": "string",
                        "title": "Timezone",
                        "description": "Timezone for the schedule."
                      }
                    },
                    "description": "Scheduling configuration for the monitor."
                  },
                  "lastRun": {
                    "type": "object",
                    "title": "Last Run",
                    "required": [
                      "status"
                    ],
                    "properties": {
                      "status": {
                        "type": "string",
                        "title": "Status",
                        "description": "Status of the last run."
                      },
                      "startedAt": {
                        "type": "string",
                        "title": "Started At",
                        "description": "Timestamp when the run started."
                      },
                      "completedAt": {
                        "type": "string",
                        "title": "Completed At",
                        "description": "Timestamp when the run completed."
                      }
                    },
                    "description": "Information about the most recent monitor execution."
                  },
                  "behavior": {
                    "type": "object",
                    "title": "Behavior",
                    "required": [
                      "type"
                    ],
                    "properties": {
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Behavior type, typically 'search'."
                      },
                      "config": {
                        "type": "object",
                        "title": "Config",
                        "description": "Configuration parameters for the behavior.",
                        "additionalProperties": true
                      }
                    },
                    "description": "Monitor behavior configuration."
                  },
                  "metadata": {
                    "type": "object",
                    "title": "Metadata",
                    "description": "Custom key-value pairs (max 1000 characters per value).",
                    "additionalProperties": true
                  },
                  "websetId": {
                    "type": "string",
                    "title": "Webset Id",
                    "description": "ID of the parent webset."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "ISO 8601 timestamp when the monitor was created."
                  },
                  "nextRunAt": {
                    "type": "string",
                    "title": "Next Run At",
                    "description": "ISO 8601 timestamp of the next scheduled execution. Nullable."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "ISO 8601 timestamp when the monitor was last updated."
                  }
                }
              },
              "title": "Monitors",
              "description": "Array of monitors that continuously keep websets updated with fresh data through scheduled operations."
            },
            "searches": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SearchItem",
                "required": [
                  "id",
                  "object",
                  "status",
                  "websetId",
                  "query",
                  "entity",
                  "criteria",
                  "count",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the search."
                  },
                  "count": {
                    "type": "integer",
                    "title": "Count",
                    "description": "Target number of results to find."
                  },
                  "query": {
                    "type": "string",
                    "title": "Query",
                    "description": "Search query string."
                  },
                  "scope": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "additionalProperties": true
                    },
                    "title": "Scope",
                    "description": "Search scope boundaries with relationship definitions."
                  },
                  "entity": {
                    "type": "object",
                    "title": "Entity",
                    "description": "Entity type configuration for the search (e.g., company, person, article, research-paper, custom).",
                    "additionalProperties": true
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "Object type, always 'webset_search'."
                  },
                  "recall": {
                    "type": "object",
                    "title": "Recall",
                    "required": [
                      "expected",
                      "reasoning"
                    ],
                    "properties": {
                      "expected": {
                        "type": "object",
                        "title": "Expected",
                        "required": [
                          "total",
                          "confidence",
                          "bounds"
                        ],
                        "properties": {
                          "total": {
                            "type": "integer",
                            "title": "Total",
                            "description": "Expected total number of results."
                          },
                          "bounds": {
                            "type": "object",
                            "title": "Bounds",
                            "required": [
                              "min",
                              "max"
                            ],
                            "properties": {
                              "max": {
                                "type": "integer",
                                "title": "Max",
                                "description": "Maximum bound value."
                              },
                              "min": {
                                "type": "integer",
                                "title": "Min",
                                "description": "Minimum bound value."
                              }
                            },
                            "description": "Bounds of the expected results."
                          },
                          "confidence": {
                            "type": "string",
                            "title": "Confidence",
                            "description": "Confidence level of the expectation."
                          }
                        },
                        "description": "Details of expected recall metrics."
                      },
                      "reasoning": {
                        "type": "string",
                        "title": "Reasoning",
                        "description": "Reasoning behind recall estimates."
                      }
                    },
                    "description": "Expected total results with confidence levels."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Current status of the search."
                  },
                  "exclude": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "additionalProperties": true
                    },
                    "title": "Exclude",
                    "description": "Array of sources to exclude from search results."
                  },
                  "behavior": {
                    "type": "string",
                    "title": "Behavior",
                    "description": "Search behavior mode: 'override' or 'append'."
                  },
                  "criteria": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "Criteria",
                      "required": [
                        "description",
                        "successRate"
                      ],
                      "properties": {
                        "description": {
                          "type": "string",
                          "title": "Description",
                          "description": "Description of the criterion."
                        },
                        "successRate": {
                          "type": "number",
                          "title": "Success Rate",
                          "description": "Success rate threshold (0-100)."
                        }
                      }
                    },
                    "title": "Criteria",
                    "description": "Evaluation criteria for matching results."
                  },
                  "metadata": {
                    "type": "object",
                    "title": "Metadata",
                    "description": "Custom key-value pairs (max 1000 characters per value).",
                    "additionalProperties": true
                  },
                  "progress": {
                    "type": "object",
                    "title": "Progress",
                    "properties": {
                      "found": {
                        "type": "integer",
                        "title": "Found",
                        "description": "Number of results found so far."
                      },
                      "analyzed": {
                        "type": "integer",
                        "title": "Analyzed",
                        "description": "Number of pages analyzed."
                      },
                      "timeLeft": {
                        "type": "string",
                        "title": "Time Left",
                        "description": "Estimated time remaining."
                      },
                      "completion": {
                        "type": "number",
                        "title": "Completion",
                        "description": "Completion percentage."
                      }
                    },
                    "description": "Search progress information."
                  },
                  "websetId": {
                    "type": "string",
                    "title": "Webset Id",
                    "description": "ID of the parent webset."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "ISO 8601 timestamp when the search was created."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "ISO 8601 timestamp when the search was last updated."
                  },
                  "canceledAt": {
                    "type": "string",
                    "title": "Canceled At",
                    "description": "Timestamp when the search was canceled."
                  },
                  "canceledReason": {
                    "type": "string",
                    "title": "Canceled Reason",
                    "description": "Reason for search cancellation."
                  }
                }
              },
              "title": "Searches",
              "description": "Array of search operations associated with the webset."
            },
            "createdAt": {
              "type": "string",
              "title": "Created At",
              "description": "ISO 8601 timestamp when the object was created."
            },
            "updatedAt": {
              "type": "string",
              "title": "Updated At",
              "description": "ISO 8601 timestamp when the object was last updated."
            },
            "externalId": {
              "type": "string",
              "title": "External Id",
              "description": "Your internal identifier for the object. Nullable."
            },
            "enrichments": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Enrichment",
                "required": [
                  "id",
                  "object",
                  "status",
                  "websetId",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the enrichment."
                  },
                  "title": {
                    "type": "string",
                    "title": "Title",
                    "description": "Title of the enrichment. Nullable."
                  },
                  "format": {
                    "type": "string",
                    "title": "Format",
                    "description": "Format of enriched data (e.g., text, date, number, options, email, phone, url). Nullable."
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "Object type, always 'webset_enrichment'."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Current status of the enrichment."
                  },
                  "options": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "Option",
                      "required": [
                        "label"
                      ],
                      "properties": {
                        "label": {
                          "type": "string",
                          "title": "Label",
                          "description": "Label of the enrichment option."
                        }
                      }
                    },
                    "title": "Options",
                    "description": "Available options when format is 'options'. Nullable."
                  },
                  "metadata": {
                    "type": "object",
                    "title": "Metadata",
                    "description": "Custom key-value pairs (max 1000 characters per value).",
                    "additionalProperties": true
                  },
                  "websetId": {
                    "type": "string",
                    "title": "Webset Id",
                    "description": "ID of the parent webset."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "ISO 8601 timestamp when the enrichment was created."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "ISO 8601 timestamp when the enrichment was last updated."
                  },
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Description of what data the enrichment extracts. Nullable."
                  },
                  "instructions": {
                    "type": "string",
                    "title": "Instructions",
                    "description": "Agent instructions for the enrichment task. Nullable."
                  }
                }
              },
              "title": "Enrichments",
              "description": "Array of enrichment tasks that enhance webset items with additional structured data."
            }
          },
          "description": "Event payload containing the data for the triggered event. Structure varies by event type."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of event. One of: webset.created, webset.deleted, webset.idle, webset.paused, webset.item_created, webset.item_enriched, webset.search_created, webset.search_updated, webset.search_canceled, webset.search_completed, import.created, import.completed, monitor.created, monitor.updated, monitor.deleted, monitor_run.created, monitor_run.completed."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Object type, always 'event'."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the event was created."
        }
      },
      "description": "Response schema for the Exa GET /websets/v0/events/{id} endpoint. Returns a union type representing one of 17 different event types."
    }
  },
  "title": "GetEventResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "object",
        "type",
        "data",
        "createdAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the event."
        },
        "data": {
          "type": "object",
          "title": "Data",
          "required": [
            "id",
            "object",
            "status",
            "createdAt",
            "updatedAt"
          ],
          "properties": {
            "id": {
              "type": "string",
              "title": "Id",
              "description": "Unique identifier for the object that triggered the event (webset, import, monitor, etc.)."
            },
            "title": {
              "type": "string",
              "title": "Title",
              "description": "Display name or title of the object. Nullable."
            },
            "object": {
              "type": "string",
              "title": "Object",
              "description": "Object type (e.g., 'webset', 'import', 'monitor')."
            },
            "status": {
              "type": "string",
              "title": "Status",
              "description": "Current status of the object. Values include: idle, pending, running, paused, created, completed, canceled, failed."
            },
            "imports": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "ImportItem",
                "required": [
                  "id",
                  "object",
                  "status",
                  "format",
                  "entity",
                  "title",
                  "count",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the import."
                  },
                  "count": {
                    "type": "integer",
                    "title": "Count",
                    "description": "Number of items imported."
                  },
                  "title": {
                    "type": "string",
                    "title": "Title",
                    "description": "Title of the import."
                  },
                  "entity": {
                    "type": "object",
                    "title": "Entity",
                    "description": "Entity type classification for imported data.",
                    "additionalProperties": true
                  },
                  "format": {
                    "type": "string",
                    "title": "Format",
                    "description": "Format of the imported data (e.g., 'csv', 'webset')."
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "Object type, always 'import'."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Current status of the import."
                  },
                  "failedAt": {
                    "type": "string",
                    "title": "Failed At",
                    "description": "Timestamp when the import failed. Nullable."
                  },
                  "metadata": {
                    "type": "object",
                    "title": "Metadata",
                    "description": "Custom key-value pairs (max 1000 characters per value).",
                    "additionalProperties": true
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "ISO 8601 timestamp when the import was created."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "ISO 8601 timestamp when the import was last updated."
                  },
                  "failedReason": {
                    "type": "string",
                    "title": "Failed Reason",
                    "description": "Reason for import failure. Nullable."
                  },
                  "failedMessage": {
                    "type": "string",
                    "title": "Failed Message",
                    "description": "Detailed error message for import failure. Nullable."
                  }
                }
              },
              "title": "Imports",
              "description": "Array of import operations for uploading data into websets."
            },
            "excludes": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Exclude",
                "required": [
                  "source",
                  "id"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "ID of the exclusion source."
                  },
                  "source": {
                    "type": "string",
                    "title": "Source",
                    "description": "Source type for exclusion (e.g., 'import', 'webset')."
                  }
                }
              },
              "title": "Excludes",
              "description": "Global exclusion sources applied across all operations."
            },
            "metadata": {
              "type": "object",
              "title": "Metadata",
              "description": "Custom key-value pairs for storing additional information (max 1000 characters per value).",
              "additionalProperties": true
            },
            "monitors": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Monitor",
                "required": [
                  "id",
                  "object",
                  "status",
                  "websetId",
                  "cadence",
                  "behavior",
                  "lastRun",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the monitor."
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "Object type, always 'monitor'."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Current status of the monitor."
                  },
                  "cadence": {
                    "type": "object",
                    "title": "Cadence",
                    "required": [
                      "cron",
                      "timezone"
                    ],
                    "properties": {
                      "cron": {
                        "type": "string",
                        "title": "Cron",
                        "description": "Cron expression defining the schedule."
                      },
                      "timezone": {
                        "type": "string",
                        "title": "Timezone",
                        "description": "Timezone for the schedule."
                      }
                    },
                    "description": "Scheduling configuration for the monitor."
                  },
                  "lastRun": {
                    "type": "object",
                    "title": "Last Run",
                    "required": [
                      "status"
                    ],
                    "properties": {
                      "status": {
                        "type": "string",
                        "title": "Status",
                        "description": "Status of the last run."
                      },
                      "startedAt": {
                        "type": "string",
                        "title": "Started At",
                        "description": "Timestamp when the run started."
                      },
                      "completedAt": {
                        "type": "string",
                        "title": "Completed At",
                        "description": "Timestamp when the run completed."
                      }
                    },
                    "description": "Information about the most recent monitor execution."
                  },
                  "behavior": {
                    "type": "object",
                    "title": "Behavior",
                    "required": [
                      "type"
                    ],
                    "properties": {
                      "type": {
                        "type": "string",
                        "title": "Type",
                        "description": "Behavior type, typically 'search'."
                      },
                      "config": {
                        "type": "object",
                        "title": "Config",
                        "description": "Configuration parameters for the behavior.",
                        "additionalProperties": true
                      }
                    },
                    "description": "Monitor behavior configuration."
                  },
                  "metadata": {
                    "type": "object",
                    "title": "Metadata",
                    "description": "Custom key-value pairs (max 1000 characters per value).",
                    "additionalProperties": true
                  },
                  "websetId": {
                    "type": "string",
                    "title": "Webset Id",
                    "description": "ID of the parent webset."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "ISO 8601 timestamp when the monitor was created."
                  },
                  "nextRunAt": {
                    "type": "string",
                    "title": "Next Run At",
                    "description": "ISO 8601 timestamp of the next scheduled execution. Nullable."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "ISO 8601 timestamp when the monitor was last updated."
                  }
                }
              },
              "title": "Monitors",
              "description": "Array of monitors that continuously keep websets updated with fresh data through scheduled operations."
            },
            "searches": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "SearchItem",
                "required": [
                  "id",
                  "object",
                  "status",
                  "websetId",
                  "query",
                  "entity",
                  "criteria",
                  "count",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the search."
                  },
                  "count": {
                    "type": "integer",
                    "title": "Count",
                    "description": "Target number of results to find."
                  },
                  "query": {
                    "type": "string",
                    "title": "Query",
                    "description": "Search query string."
                  },
                  "scope": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "additionalProperties": true
                    },
                    "title": "Scope",
                    "description": "Search scope boundaries with relationship definitions."
                  },
                  "entity": {
                    "type": "object",
                    "title": "Entity",
                    "description": "Entity type configuration for the search (e.g., company, person, article, research-paper, custom).",
                    "additionalProperties": true
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "Object type, always 'webset_search'."
                  },
                  "recall": {
                    "type": "object",
                    "title": "Recall",
                    "required": [
                      "expected",
                      "reasoning"
                    ],
                    "properties": {
                      "expected": {
                        "type": "object",
                        "title": "Expected",
                        "required": [
                          "total",
                          "confidence",
                          "bounds"
                        ],
                        "properties": {
                          "total": {
                            "type": "integer",
                            "title": "Total",
                            "description": "Expected total number of results."
                          },
                          "bounds": {
                            "type": "object",
                            "title": "Bounds",
                            "required": [
                              "min",
                              "max"
                            ],
                            "properties": {
                              "max": {
                                "type": "integer",
                                "title": "Max",
                                "description": "Maximum bound value."
                              },
                              "min": {
                                "type": "integer",
                                "title": "Min",
                                "description": "Minimum bound value."
                              }
                            },
                            "description": "Bounds of the expected results."
                          },
                          "confidence": {
                            "type": "string",
                            "title": "Confidence",
                            "description": "Confidence level of the expectation."
                          }
                        },
                        "description": "Details of expected recall metrics."
                      },
                      "reasoning": {
                        "type": "string",
                        "title": "Reasoning",
                        "description": "Reasoning behind recall estimates."
                      }
                    },
                    "description": "Expected total results with confidence levels."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Current status of the search."
                  },
                  "exclude": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "additionalProperties": true
                    },
                    "title": "Exclude",
                    "description": "Array of sources to exclude from search results."
                  },
                  "behavior": {
                    "type": "string",
                    "title": "Behavior",
                    "description": "Search behavior mode: 'override' or 'append'."
                  },
                  "criteria": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "Criteria",
                      "required": [
                        "description",
                        "successRate"
                      ],
                      "properties": {
                        "description": {
                          "type": "string",
                          "title": "Description",
                          "description": "Description of the criterion."
                        },
                        "successRate": {
                          "type": "number",
                          "title": "Success Rate",
                          "description": "Success rate threshold (0-100)."
                        }
                      }
                    },
                    "title": "Criteria",
                    "description": "Evaluation criteria for matching results."
                  },
                  "metadata": {
                    "type": "object",
                    "title": "Metadata",
                    "description": "Custom key-value pairs (max 1000 characters per value).",
                    "additionalProperties": true
                  },
                  "progress": {
                    "type": "object",
                    "title": "Progress",
                    "properties": {
                      "found": {
                        "type": "integer",
                        "title": "Found",
                        "description": "Number of results found so far."
                      },
                      "analyzed": {
                        "type": "integer",
                        "title": "Analyzed",
                        "description": "Number of pages analyzed."
                      },
                      "timeLeft": {
                        "type": "string",
                        "title": "Time Left",
                        "description": "Estimated time remaining."
                      },
                      "completion": {
                        "type": "number",
                        "title": "Completion",
                        "description": "Completion percentage."
                      }
                    },
                    "description": "Search progress information."
                  },
                  "websetId": {
                    "type": "string",
                    "title": "Webset Id",
                    "description": "ID of the parent webset."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "ISO 8601 timestamp when the search was created."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "ISO 8601 timestamp when the search was last updated."
                  },
                  "canceledAt": {
                    "type": "string",
                    "title": "Canceled At",
                    "description": "Timestamp when the search was canceled."
                  },
                  "canceledReason": {
                    "type": "string",
                    "title": "Canceled Reason",
                    "description": "Reason for search cancellation."
                  }
                }
              },
              "title": "Searches",
              "description": "Array of search operations associated with the webset."
            },
            "createdAt": {
              "type": "string",
              "title": "Created At",
              "description": "ISO 8601 timestamp when the object was created."
            },
            "updatedAt": {
              "type": "string",
              "title": "Updated At",
              "description": "ISO 8601 timestamp when the object was last updated."
            },
            "externalId": {
              "type": "string",
              "title": "External Id",
              "description": "Your internal identifier for the object. Nullable."
            },
            "enrichments": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "Enrichment",
                "required": [
                  "id",
                  "object",
                  "status",
                  "websetId",
                  "createdAt",
                  "updatedAt"
                ],
                "properties": {
                  "id": {
                    "type": "string",
                    "title": "Id",
                    "description": "Unique identifier for the enrichment."
                  },
                  "title": {
                    "type": "string",
                    "title": "Title",
                    "description": "Title of the enrichment. Nullable."
                  },
                  "format": {
                    "type": "string",
                    "title": "Format",
                    "description": "Format of enriched data (e.g., text, date, number, options, email, phone, url). Nullable."
                  },
                  "object": {
                    "type": "string",
                    "title": "Object",
                    "description": "Object type, always 'webset_enrichment'."
                  },
                  "status": {
                    "type": "string",
                    "title": "Status",
                    "description": "Current status of the enrichment."
                  },
                  "options": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "Option",
                      "required": [
                        "label"
                      ],
                      "properties": {
                        "label": {
                          "type": "string",
                          "title": "Label",
                          "description": "Label of the enrichment option."
                        }
                      }
                    },
                    "title": "Options",
                    "description": "Available options when format is 'options'. Nullable."
                  },
                  "metadata": {
                    "type": "object",
                    "title": "Metadata",
                    "description": "Custom key-value pairs (max 1000 characters per value).",
                    "additionalProperties": true
                  },
                  "websetId": {
                    "type": "string",
                    "title": "Webset Id",
                    "description": "ID of the parent webset."
                  },
                  "createdAt": {
                    "type": "string",
                    "title": "Created At",
                    "description": "ISO 8601 timestamp when the enrichment was created."
                  },
                  "updatedAt": {
                    "type": "string",
                    "title": "Updated At",
                    "description": "ISO 8601 timestamp when the enrichment was last updated."
                  },
                  "description": {
                    "type": "string",
                    "title": "Description",
                    "description": "Description of what data the enrichment extracts. Nullable."
                  },
                  "instructions": {
                    "type": "string",
                    "title": "Instructions",
                    "description": "Agent instructions for the enrichment task. Nullable."
                  }
                }
              },
              "title": "Enrichments",
              "description": "Array of enrichment tasks that enhance webset items with additional structured data."
            }
          },
          "description": "Event payload containing the data for the triggered event. Structure varies by event type."
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of event. One of: webset.created, webset.deleted, webset.idle, webset.paused, webset.item_created, webset.item_enriched, webset.search_created, webset.search_updated, webset.search_canceled, webset.search_completed, import.created, import.completed, monitor.created, monitor.updated, monitor.deleted, monitor_run.created, monitor_run.completed."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Object type, always 'event'."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO 8601 timestamp when the event was created."
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

## EXA_GET_RESEARCH
Tool to retrieve the status and results of a previously created research task. Use the unique researchId returned from POST /research/v1 to poll until the task is finished.

**Input schema:**
```json
{
  "type": "object",
  "title": "GetResearchRequest",
  "required": [
    "researchId"
  ],
  "properties": {
    "events": {
      "type": "boolean",
      "title": "Events",
      "description": "Set to 'true' to include the detailed event log of all operations performed. Defaults to false."
    },
    "stream": {
      "type": "boolean",
      "title": "Stream",
      "description": "Set to 'true' to receive real-time updates via Server-Sent Events (SSE). Defaults to false."
    },
    "researchId": {
      "type": "string",
      "title": "Research Id",
      "examples": [
        "r_01khd5mxy8cbtq58bvsqxkapp0"
      ],
      "description": "The unique identifier of the research task to retrieve. This ID is returned when creating a research task via POST /research/v1."
    }
  },
  "description": "Parameters to retrieve a specific research task by ID."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CostDollars": {
      "type": "object",
      "title": "CostDollars",
      "properties": {
        "llm": {
          "type": "number",
          "title": "Llm",
          "description": "Cost of LLM/AI model operations."
        },
        "total": {
          "type": "number",
          "title": "Total",
          "description": "Total dollar cost for the research task."
        },
        "search": {
          "type": "number",
          "title": "Search",
          "description": "Cost of search operations."
        }
      },
      "description": "Cost breakdown for the research task."
    },
    "ResearchEvent": {
      "type": "object",
      "title": "ResearchEvent",
      "properties": {
        "data": {
          "type": "object",
          "title": "Data",
          "description": "Additional data associated with the event.",
          "additionalProperties": true
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the event."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Event message or description."
        },
        "timestamp": {
          "type": "number",
          "title": "Timestamp",
          "description": "Unix timestamp of when the event occurred."
        }
      },
      "description": "Represents a single event in the research task execution log."
    },
    "ResearchOutput": {
      "type": "object",
      "title": "ResearchOutput",
      "properties": {
        "text": {
          "type": "string",
          "title": "Text",
          "description": "The research output text or summary."
        },
        "markdown": {
          "type": "string",
          "title": "Markdown",
          "description": "The research output in markdown format."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Additional metadata about the research output.",
          "additionalProperties": true
        },
        "citations": {
          "type": "array",
          "items": {
            "type": "object",
            "additionalProperties": true
          },
          "title": "Citations",
          "description": "Citations and sources used in the research."
        }
      },
      "description": "The output/result of a completed research task."
    },
    "GetResearchResponse": {
      "type": "object",
      "title": "GetResearchResponse",
      "required": [
        "researchId",
        "createdAt",
        "instructions",
        "status"
      ],
      "properties": {
        "error": {
          "type": "string",
          "title": "Error",
          "description": "Error message describing what went wrong. Only present when status is 'failed'."
        },
        "model": {
          "type": "string",
          "title": "Model",
          "description": "The AI model used for the research task, if specified."
        },
        "events": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResearchEvent",
            "properties": {
              "data": {
                "type": "object",
                "title": "Data",
                "description": "Additional data associated with the event.",
                "additionalProperties": true
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of the event."
              },
              "message": {
                "type": "string",
                "title": "Message",
                "description": "Event message or description."
              },
              "timestamp": {
                "type": "number",
                "title": "Timestamp",
                "description": "Unix timestamp of when the event occurred."
              }
            },
            "description": "Represents a single event in the research task execution log."
          },
          "title": "Events",
          "description": "Detailed event log of all operations performed during the research task. Only included if the 'events' query parameter was set to true."
        },
        "output": {
          "type": "object",
          "title": "Output",
          "properties": {
            "text": {
              "type": "string",
              "title": "Text",
              "description": "The research output text or summary."
            },
            "markdown": {
              "type": "string",
              "title": "Markdown",
              "description": "The research output in markdown format."
            },
            "metadata": {
              "type": "object",
              "title": "Metadata",
              "description": "Additional metadata about the research output.",
              "additionalProperties": true
            },
            "citations": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Citations",
              "description": "Citations and sources used in the research."
            }
          },
          "description": "The research output/results. Only present when status is 'completed'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the research task. Values: 'pending', 'running', 'completed', 'failed'."
        },
        "createdAt": {
          "type": "number",
          "title": "Created At",
          "description": "Unix timestamp of when the research task was created."
        },
        "researchId": {
          "type": "string",
          "title": "Research Id",
          "description": "The unique identifier of the research task."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "properties": {
            "llm": {
              "type": "number",
              "title": "Llm",
              "description": "Cost of LLM/AI model operations."
            },
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total dollar cost for the research task."
            },
            "search": {
              "type": "number",
              "title": "Search",
              "description": "Cost of search operations."
            }
          },
          "description": "Cost breakdown for the research task. Only present when status is 'completed'."
        },
        "instructions": {
          "type": "string",
          "title": "Instructions",
          "description": "The original instructions or query provided for the research task."
        }
      },
      "description": "Response schema for the Exa GET /research/v1/{researchId} endpoint.\n\nThe response varies based on the task status:\n- Pending/Running: includes researchId, createdAt, instructions, status, model (optional), events (optional)\n- Completed: includes all fields plus output and costDollars\n- Failed: includes all fields plus error message"
    }
  },
  "title": "GetResearchResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "researchId",
        "createdAt",
        "instructions",
        "status"
      ],
      "properties": {
        "error": {
          "type": "string",
          "title": "Error",
          "description": "Error message describing what went wrong. Only present when status is 'failed'."
        },
        "model": {
          "type": "string",
          "title": "Model",
          "description": "The AI model used for the research task, if specified."
        },
        "events": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResearchEvent",
            "properties": {
              "data": {
                "type": "object",
                "title": "Data",
                "description": "Additional data associated with the event.",
                "additionalProperties": true
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of the event."
              },
              "message": {
                "type": "string",
                "title": "Message",
                "description": "Event message or description."
              },
              "timestamp": {
                "type": "number",
                "title": "Timestamp",
                "description": "Unix timestamp of when the event occurred."
              }
            },
            "description": "Represents a single event in the research task execution log."
          },
          "title": "Events",
          "description": "Detailed event log of all operations performed during the research task. Only included if the 'events' query parameter was set to true."
        },
        "output": {
          "type": "object",
          "title": "Output",
          "properties": {
            "text": {
              "type": "string",
              "title": "Text",
              "description": "The research output text or summary."
            },
            "markdown": {
              "type": "string",
              "title": "Markdown",
              "description": "The research output in markdown format."
            },
            "metadata": {
              "type": "object",
              "title": "Metadata",
              "description": "Additional metadata about the research output.",
              "additionalProperties": true
            },
            "citations": {
              "type": "array",
              "items": {
                "type": "object",
                "additionalProperties": true
              },
              "title": "Citations",
              "description": "Citations and sources used in the research."
            }
          },
          "description": "The research output/results. Only present when status is 'completed'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the research task. Values: 'pending', 'running', 'completed', 'failed'."
        },
        "createdAt": {
          "type": "number",
          "title": "Created At",
          "description": "Unix timestamp of when the research task was created."
        },
        "researchId": {
          "type": "string",
          "title": "Research Id",
          "description": "The unique identifier of the research task."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "properties": {
            "llm": {
              "type": "number",
              "title": "Llm",
              "description": "Cost of LLM/AI model operations."
            },
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total dollar cost for the research task."
            },
            "search": {
              "type": "number",
              "title": "Search",
              "description": "Cost of search operations."
            }
          },
          "description": "Cost breakdown for the research task. Only present when status is 'completed'."
        },
        "instructions": {
          "type": "string",
          "title": "Instructions",
          "description": "The original instructions or query provided for the research task."
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

## EXA_LIST_EVENTS
Tool to list all events that have occurred in the system. Use when you need to paginate through the event history.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListEventsRequest",
  "properties": {
    "limit": {
      "type": "integer",
      "title": "Limit",
      "default": 25,
      "maximum": 200,
      "minimum": 1,
      "examples": [
        25
      ],
      "description": "The number of results to return (1\u2013200, default 25)."
    },
    "types": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Types",
      "examples": [
        "webset.created",
        "webset.deleted"
      ],
      "description": "Filter events by one or more event types."
    },
    "cursor": {
      "type": "string",
      "title": "Cursor",
      "examples": [
        "abcdef123"
      ],
      "minLength": 1,
      "description": "The cursor to paginate through the results."
    },
    "createdAfter": {
      "type": "string",
      "title": "Created After",
      "examples": [
        "2023-11-07T00:00:00Z"
      ],
      "description": "Filter events created at or after this UTC timestamp (inclusive). Must be a valid ISO 8601 datetime string."
    },
    "createdBefore": {
      "type": "string",
      "title": "Created Before",
      "examples": [
        "2023-11-07T05:31:56Z"
      ],
      "description": "Filter events created at or before this UTC timestamp (inclusive). Must be a valid ISO 8601 datetime string."
    }
  },
  "description": "Parameters to list all events in the system."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "EventItem": {
      "type": "object",
      "title": "EventItem",
      "required": [
        "object",
        "type",
        "data",
        "createdAt"
      ],
      "properties": {
        "data": {
          "type": "object",
          "title": "Data",
          "description": "Detailed payload of the event.",
          "additionalProperties": true
        },
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the event, e.g., 'webset.created'."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "Type of the object, always 'event'."
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the event was created."
        }
      },
      "description": "One event record."
    },
    "ListEventsResponse": {
      "type": "object",
      "title": "ListEventsResponse",
      "required": [
        "data",
        "hasMore"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "EventItem",
            "required": [
              "object",
              "type",
              "data",
              "createdAt"
            ],
            "properties": {
              "data": {
                "type": "object",
                "title": "Data",
                "description": "Detailed payload of the event.",
                "additionalProperties": true
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of the event, e.g., 'webset.created'."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "Type of the object, always 'event'."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when the event was created."
              }
            },
            "description": "One event record."
          },
          "title": "Data",
          "description": "The list of event records."
        },
        "hasMore": {
          "type": "boolean",
          "title": "Has More",
          "description": "Whether there are more results to paginate through."
        },
        "nextCursor": {
          "type": "string",
          "title": "Next Cursor",
          "description": "The cursor for the next page of results, if any."
        }
      },
      "description": "Response model for listing events."
    }
  },
  "title": "ListEventsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "data",
        "hasMore"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "EventItem",
            "required": [
              "object",
              "type",
              "data",
              "createdAt"
            ],
            "properties": {
              "data": {
                "type": "object",
                "title": "Data",
                "description": "Detailed payload of the event.",
                "additionalProperties": true
              },
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of the event, e.g., 'webset.created'."
              },
              "object": {
                "type": "string",
                "title": "Object",
                "description": "Type of the object, always 'event'."
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "Timestamp when the event was created."
              }
            },
            "description": "One event record."
          },
          "title": "Data",
          "description": "The list of event records."
        },
        "hasMore": {
          "type": "boolean",
          "title": "Has More",
          "description": "Whether there are more results to paginate through."
        },
        "nextCursor": {
          "type": "string",
          "title": "Next Cursor",
          "description": "The cursor for the next page of results, if any."
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

## EXA_LIST_IMPORTS
Tool to list all imports for the Webset. Use when you need to paginate through and monitor import jobs.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListImportsRequest",
  "properties": {
    "limit": {
      "type": "integer",
      "title": "Limit",
      "default": 25,
      "maximum": 200,
      "minimum": 1,
      "examples": [
        25
      ],
      "description": "The number of results to return (1\u2013200, default 25)."
    },
    "cursor": {
      "type": "string",
      "title": "Cursor",
      "examples": [
        "abcdef123"
      ],
      "minLength": 1,
      "description": "The cursor to paginate through the results."
    }
  },
  "description": "Parameters for listing imports in a Webset."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "ImportItem": {
      "type": "object",
      "title": "ImportItem",
      "required": [
        "id",
        "object",
        "status",
        "format",
        "entity",
        "title",
        "count",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "The number of entities in the import."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "enum": [
                "company",
                "person",
                "article",
                "research_paper",
                "custom"
              ],
              "type": "string",
              "title": "Type",
              "description": "The type of entity the import contains."
            }
          },
          "description": "Entity information for this import."
        },
        "format": {
          "enum": [
            "csv",
            "webset"
          ],
          "type": "string",
          "title": "Format",
          "description": "The format of the import."
        },
        "object": {
          "type": "string",
          "const": "import",
          "title": "Object",
          "description": "The object type."
        },
        "status": {
          "enum": [
            "pending",
            "processing",
            "completed",
            "failed"
          ],
          "type": "string",
          "title": "Status",
          "description": "The status of the import."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "When the import failed, if applicable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Key-value pairs associated with this import.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "When the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "When the import was last updated."
        },
        "failedReason": {
          "enum": [
            "invalid_format",
            "invalid_file_content",
            "missing_identifier"
          ],
          "type": "string",
          "title": "Failed Reason",
          "description": "The reason the import failed, if status is failed."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "A human-readable message for the import failure, if any."
        }
      },
      "description": "One import job record."
    },
    "ImportEntity": {
      "type": "object",
      "title": "ImportEntity",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "enum": [
            "company",
            "person",
            "article",
            "research_paper",
            "custom"
          ],
          "type": "string",
          "title": "Type",
          "description": "The type of entity the import contains."
        }
      },
      "description": "The type of entity contained in the import."
    },
    "ListImportsResponse": {
      "type": "object",
      "title": "ListImportsResponse",
      "required": [
        "data",
        "hasMore"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImportItem",
            "required": [
              "id",
              "object",
              "status",
              "format",
              "entity",
              "title",
              "count",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the import."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "The number of entities in the import."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the import."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "required": [
                  "type"
                ],
                "properties": {
                  "type": {
                    "enum": [
                      "company",
                      "person",
                      "article",
                      "research_paper",
                      "custom"
                    ],
                    "type": "string",
                    "title": "Type",
                    "description": "The type of entity the import contains."
                  }
                },
                "description": "Entity information for this import."
              },
              "format": {
                "enum": [
                  "csv",
                  "webset"
                ],
                "type": "string",
                "title": "Format",
                "description": "The format of the import."
              },
              "object": {
                "type": "string",
                "const": "import",
                "title": "Object",
                "description": "The object type."
              },
              "status": {
                "enum": [
                  "pending",
                  "processing",
                  "completed",
                  "failed"
                ],
                "type": "string",
                "title": "Status",
                "description": "The status of the import."
              },
              "failedAt": {
                "type": "string",
                "title": "Failed At",
                "description": "When the import failed, if applicable."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Key-value pairs associated with this import.",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "When the import was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "When the import was last updated."
              },
              "failedReason": {
                "enum": [
                  "invalid_format",
                  "invalid_file_content",
                  "missing_identifier"
                ],
                "type": "string",
                "title": "Failed Reason",
                "description": "The reason the import failed, if status is failed."
              },
              "failedMessage": {
                "type": "string",
                "title": "Failed Message",
                "description": "A human-readable message for the import failure, if any."
              }
            },
            "description": "One import job record."
          },
          "title": "Data",
          "description": "The list of import records."
        },
        "hasMore": {
          "type": "boolean",
          "title": "Has More",
          "description": "Whether there are more results to paginate through."
        },
        "nextCursor": {
          "type": "string",
          "title": "Next Cursor",
          "description": "The cursor for the next page of results, if any."
        }
      },
      "description": "Response model for listing imports in a Webset."
    }
  },
  "title": "ListImportsResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "data",
        "hasMore"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ImportItem",
            "required": [
              "id",
              "object",
              "status",
              "format",
              "entity",
              "title",
              "count",
              "metadata",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "The unique identifier for the import."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "The number of entities in the import."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "The title of the import."
              },
              "entity": {
                "type": "object",
                "title": "Entity",
                "required": [
                  "type"
                ],
                "properties": {
                  "type": {
                    "enum": [
                      "company",
                      "person",
                      "article",
                      "research_paper",
                      "custom"
                    ],
                    "type": "string",
                    "title": "Type",
                    "description": "The type of entity the import contains."
                  }
                },
                "description": "Entity information for this import."
              },
              "format": {
                "enum": [
                  "csv",
                  "webset"
                ],
                "type": "string",
                "title": "Format",
                "description": "The format of the import."
              },
              "object": {
                "type": "string",
                "const": "import",
                "title": "Object",
                "description": "The object type."
              },
              "status": {
                "enum": [
                  "pending",
                  "processing",
                  "completed",
                  "failed"
                ],
                "type": "string",
                "title": "Status",
                "description": "The status of the import."
              },
              "failedAt": {
                "type": "string",
                "title": "Failed At",
                "description": "When the import failed, if applicable."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Key-value pairs associated with this import.",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "When the import was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "When the import was last updated."
              },
              "failedReason": {
                "enum": [
                  "invalid_format",
                  "invalid_file_content",
                  "missing_identifier"
                ],
                "type": "string",
                "title": "Failed Reason",
                "description": "The reason the import failed, if status is failed."
              },
              "failedMessage": {
                "type": "string",
                "title": "Failed Message",
                "description": "A human-readable message for the import failure, if any."
              }
            },
            "description": "One import job record."
          },
          "title": "Data",
          "description": "The list of import records."
        },
        "hasMore": {
          "type": "boolean",
          "title": "Has More",
          "description": "Whether there are more results to paginate through."
        },
        "nextCursor": {
          "type": "string",
          "title": "Next Cursor",
          "description": "The cursor for the next page of results, if any."
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

## EXA_LIST_RESEARCH
Tool to retrieve a paginated list of your research tasks. Use when you need to view or monitor research jobs with cursor-based pagination.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListResearchRequest",
  "properties": {
    "limit": {
      "type": "integer",
      "title": "Limit",
      "default": 10,
      "maximum": 50,
      "minimum": 1,
      "examples": [
        10
      ],
      "description": "The number of results to return (1\u201350, default 10)."
    },
    "cursor": {
      "type": "string",
      "title": "Cursor",
      "examples": [
        "abcdef123"
      ],
      "minLength": 1,
      "description": "The cursor to paginate through the results."
    }
  },
  "description": "Parameters for listing research tasks."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CostDollars": {
      "type": "object",
      "title": "CostDollars",
      "properties": {
        "llm": {
          "type": "number",
          "title": "Llm",
          "description": "LLM cost in dollars."
        },
        "total": {
          "type": "number",
          "title": "Total",
          "description": "Total cost in dollars."
        },
        "search": {
          "type": "number",
          "title": "Search",
          "description": "Search cost in dollars."
        }
      },
      "description": "Cost information for completed research."
    },
    "ResearchItem": {
      "type": "object",
      "title": "ResearchItem",
      "required": [
        "researchId",
        "createdAt",
        "instructions",
        "status"
      ],
      "properties": {
        "error": {
          "type": "string",
          "title": "Error",
          "description": "Error message if the research task failed."
        },
        "model": {
          "type": "string",
          "title": "Model",
          "description": "The model used for the research task."
        },
        "events": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResearchEvent",
            "properties": {
              "type": {
                "type": "string",
                "title": "Type",
                "description": "Type of the event."
              },
              "message": {
                "type": "string",
                "title": "Message",
                "description": "Event message."
              },
              "timestamp": {
                "type": "number",
                "title": "Timestamp",
                "description": "Timestamp when the event occurred."
              }
            },
            "description": "Event information for research tasks."
          },
          "title": "Events",
          "description": "List of events associated with this research task."
        },
        "output": {
          "type": "object",
          "title": "Output",
          "properties": {
            "steps": {
              "type": "array",
              "items": {},
              "title": "Steps",
              "description": "Steps taken during research."
            },
            "answer": {
              "type": "string",
              "title": "Answer",
              "description": "The research answer."
            },
            "sources": {
              "type": "array",
              "items": {},
              "title": "Sources",
              "description": "Sources used for research."
            }
          },
          "description": "Output from the research task (present when completed)."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the research task (pending, processing, completed, failed)."
        },
        "createdAt": {
          "type": "number",
          "title": "Created At",
          "description": "When the research task was created (Unix timestamp)."
        },
        "researchId": {
          "type": "string",
          "title": "Research Id",
          "description": "The unique identifier for the research task."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "properties": {
            "llm": {
              "type": "number",
              "title": "Llm",
              "description": "LLM cost in dollars."
            },
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total cost in dollars."
            },
            "search": {
              "type": "number",
              "title": "Search",
              "description": "Search cost in dollars."
            }
          },
          "description": "Cost information (present when completed)."
        },
        "instructions": {
          "type": "string",
          "title": "Instructions",
          "description": "The instructions for the research task."
        }
      },
      "description": "One research task record."
    },
    "ResearchEvent": {
      "type": "object",
      "title": "ResearchEvent",
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "Type of the event."
        },
        "message": {
          "type": "string",
          "title": "Message",
          "description": "Event message."
        },
        "timestamp": {
          "type": "number",
          "title": "Timestamp",
          "description": "Timestamp when the event occurred."
        }
      },
      "description": "Event information for research tasks."
    },
    "ResearchOutput": {
      "type": "object",
      "title": "ResearchOutput",
      "properties": {
        "steps": {
          "type": "array",
          "items": {},
          "title": "Steps",
          "description": "Steps taken during research."
        },
        "answer": {
          "type": "string",
          "title": "Answer",
          "description": "The research answer."
        },
        "sources": {
          "type": "array",
          "items": {},
          "title": "Sources",
          "description": "Sources used for research."
        }
      },
      "description": "Output from completed research."
    },
    "ListResearchResponse": {
      "type": "object",
      "title": "ListResearchResponse",
      "required": [
        "data",
        "hasMore"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResearchItem",
            "required": [
              "researchId",
              "createdAt",
              "instructions",
              "status"
            ],
            "properties": {
              "error": {
                "type": "string",
                "title": "Error",
                "description": "Error message if the research task failed."
              },
              "model": {
                "type": "string",
                "title": "Model",
                "description": "The model used for the research task."
              },
              "events": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "ResearchEvent",
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of the event."
                    },
                    "message": {
                      "type": "string",
                      "title": "Message",
                      "description": "Event message."
                    },
                    "timestamp": {
                      "type": "number",
                      "title": "Timestamp",
                      "description": "Timestamp when the event occurred."
                    }
                  },
                  "description": "Event information for research tasks."
                },
                "title": "Events",
                "description": "List of events associated with this research task."
              },
              "output": {
                "type": "object",
                "title": "Output",
                "properties": {
                  "steps": {
                    "type": "array",
                    "items": {},
                    "title": "Steps",
                    "description": "Steps taken during research."
                  },
                  "answer": {
                    "type": "string",
                    "title": "Answer",
                    "description": "The research answer."
                  },
                  "sources": {
                    "type": "array",
                    "items": {},
                    "title": "Sources",
                    "description": "Sources used for research."
                  }
                },
                "description": "Output from the research task (present when completed)."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the research task (pending, processing, completed, failed)."
              },
              "createdAt": {
                "type": "number",
                "title": "Created At",
                "description": "When the research task was created (Unix timestamp)."
              },
              "researchId": {
                "type": "string",
                "title": "Research Id",
                "description": "The unique identifier for the research task."
              },
              "costDollars": {
                "type": "object",
                "title": "Cost Dollars",
                "properties": {
                  "llm": {
                    "type": "number",
                    "title": "Llm",
                    "description": "LLM cost in dollars."
                  },
                  "total": {
                    "type": "number",
                    "title": "Total",
                    "description": "Total cost in dollars."
                  },
                  "search": {
                    "type": "number",
                    "title": "Search",
                    "description": "Search cost in dollars."
                  }
                },
                "description": "Cost information (present when completed)."
              },
              "instructions": {
                "type": "string",
                "title": "Instructions",
                "description": "The instructions for the research task."
              }
            },
            "description": "One research task record."
          },
          "title": "Data",
          "description": "The list of research task records."
        },
        "hasMore": {
          "type": "boolean",
          "title": "Has More",
          "description": "Whether there are more results to paginate through."
        },
        "nextCursor": {
          "type": "string",
          "title": "Next Cursor",
          "description": "The cursor for the next page of results, if any."
        }
      },
      "description": "Response model for listing research tasks."
    }
  },
  "title": "ListResearchResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "data",
        "hasMore"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "ResearchItem",
            "required": [
              "researchId",
              "createdAt",
              "instructions",
              "status"
            ],
            "properties": {
              "error": {
                "type": "string",
                "title": "Error",
                "description": "Error message if the research task failed."
              },
              "model": {
                "type": "string",
                "title": "Model",
                "description": "The model used for the research task."
              },
              "events": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "ResearchEvent",
                  "properties": {
                    "type": {
                      "type": "string",
                      "title": "Type",
                      "description": "Type of the event."
                    },
                    "message": {
                      "type": "string",
                      "title": "Message",
                      "description": "Event message."
                    },
                    "timestamp": {
                      "type": "number",
                      "title": "Timestamp",
                      "description": "Timestamp when the event occurred."
                    }
                  },
                  "description": "Event information for research tasks."
                },
                "title": "Events",
                "description": "List of events associated with this research task."
              },
              "output": {
                "type": "object",
                "title": "Output",
                "properties": {
                  "steps": {
                    "type": "array",
                    "items": {},
                    "title": "Steps",
                    "description": "Steps taken during research."
                  },
                  "answer": {
                    "type": "string",
                    "title": "Answer",
                    "description": "The research answer."
                  },
                  "sources": {
                    "type": "array",
                    "items": {},
                    "title": "Sources",
                    "description": "Sources used for research."
                  }
                },
                "description": "Output from the research task (present when completed)."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "The status of the research task (pending, processing, completed, failed)."
              },
              "createdAt": {
                "type": "number",
                "title": "Created At",
                "description": "When the research task was created (Unix timestamp)."
              },
              "researchId": {
                "type": "string",
                "title": "Research Id",
                "description": "The unique identifier for the research task."
              },
              "costDollars": {
                "type": "object",
                "title": "Cost Dollars",
                "properties": {
                  "llm": {
                    "type": "number",
                    "title": "Llm",
                    "description": "LLM cost in dollars."
                  },
                  "total": {
                    "type": "number",
                    "title": "Total",
                    "description": "Total cost in dollars."
                  },
                  "search": {
                    "type": "number",
                    "title": "Search",
                    "description": "Search cost in dollars."
                  }
                },
                "description": "Cost information (present when completed)."
              },
              "instructions": {
                "type": "string",
                "title": "Instructions",
                "description": "The instructions for the research task."
              }
            },
            "description": "One research task record."
          },
          "title": "Data",
          "description": "The list of research task records."
        },
        "hasMore": {
          "type": "boolean",
          "title": "Has More",
          "description": "Whether there are more results to paginate through."
        },
        "nextCursor": {
          "type": "string",
          "title": "Next Cursor",
          "description": "The cursor for the next page of results, if any."
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

## EXA_LIST_WEBHOOKS
Tool to list all webhooks for Websets. Use when you need to view existing webhooks and paginate through results.

**Input schema:**
```json
{
  "type": "object",
  "title": "ListWebhooksRequest",
  "properties": {
    "limit": {
      "type": "integer",
      "title": "Limit",
      "default": 25,
      "maximum": 200,
      "minimum": 1,
      "examples": [
        25,
        100
      ],
      "description": "Number of results to return per page."
    },
    "cursor": {
      "type": "string",
      "title": "Cursor",
      "examples": [
        "abc123cursor"
      ],
      "minLength": 1,
      "description": "Pagination cursor returned by a previous call. Must be at least 1 character if provided."
    }
  },
  "description": "Request parameters for listing webhooks."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Webhook": {
      "type": "object",
      "title": "Webhook",
      "required": [
        "id",
        "object",
        "status",
        "events",
        "url",
        "secret",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the webhook."
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "The target URL that will receive webhook POSTs."
        },
        "events": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Events",
          "description": "List of event names this webhook is subscribed to."
        },
        "object": {
          "type": "string",
          "const": "webhook",
          "title": "Object",
          "description": "Type of this object, always 'webhook'."
        },
        "secret": {
          "type": "string",
          "title": "Secret",
          "description": "Secret used to sign webhook payloads."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "Current status of the webhook (e.g., 'active')."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Arbitrary metadata object.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "ISO-8601 timestamp when the webhook was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "ISO-8601 timestamp when the webhook was last updated."
        }
      },
      "description": "Represents a single webhook object."
    },
    "ListWebhooksResponse": {
      "type": "object",
      "title": "ListWebhooksResponse",
      "required": [
        "data",
        "hasMore"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Webhook",
            "required": [
              "id",
              "object",
              "status",
              "events",
              "url",
              "secret",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the webhook."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "description": "The target URL that will receive webhook POSTs."
              },
              "events": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Events",
                "description": "List of event names this webhook is subscribed to."
              },
              "object": {
                "type": "string",
                "const": "webhook",
                "title": "Object",
                "description": "Type of this object, always 'webhook'."
              },
              "secret": {
                "type": "string",
                "title": "Secret",
                "description": "Secret used to sign webhook payloads."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Current status of the webhook (e.g., 'active')."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Arbitrary metadata object.",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "ISO-8601 timestamp when the webhook was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "ISO-8601 timestamp when the webhook was last updated."
              }
            },
            "description": "Represents a single webhook object."
          },
          "title": "Data",
          "description": "Array of webhook objects."
        },
        "hasMore": {
          "type": "boolean",
          "title": "Has More",
          "description": "Whether more results are available."
        },
        "nextCursor": {
          "type": "string",
          "title": "Next Cursor",
          "description": "Cursor to use for the next page of results, if hasMore is true."
        }
      },
      "description": "Response schema for listing webhooks."
    }
  },
  "title": "ListWebhooksResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "data",
        "hasMore"
      ],
      "properties": {
        "data": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "Webhook",
            "required": [
              "id",
              "object",
              "status",
              "events",
              "url",
              "secret",
              "createdAt",
              "updatedAt"
            ],
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the webhook."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "description": "The target URL that will receive webhook POSTs."
              },
              "events": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Events",
                "description": "List of event names this webhook is subscribed to."
              },
              "object": {
                "type": "string",
                "const": "webhook",
                "title": "Object",
                "description": "Type of this object, always 'webhook'."
              },
              "secret": {
                "type": "string",
                "title": "Secret",
                "description": "Secret used to sign webhook payloads."
              },
              "status": {
                "type": "string",
                "title": "Status",
                "description": "Current status of the webhook (e.g., 'active')."
              },
              "metadata": {
                "type": "object",
                "title": "Metadata",
                "description": "Arbitrary metadata object.",
                "additionalProperties": true
              },
              "createdAt": {
                "type": "string",
                "title": "Created At",
                "description": "ISO-8601 timestamp when the webhook was created."
              },
              "updatedAt": {
                "type": "string",
                "title": "Updated At",
                "description": "ISO-8601 timestamp when the webhook was last updated."
              }
            },
            "description": "Represents a single webhook object."
          },
          "title": "Data",
          "description": "Array of webhook objects."
        },
        "hasMore": {
          "type": "boolean",
          "title": "Has More",
          "description": "Whether more results are available."
        },
        "nextCursor": {
          "type": "string",
          "title": "Next Cursor",
          "description": "Cursor to use for the next page of results, if hasMore is true."
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

## EXA_SEARCH
Web search via the Exa engine. Returns ranked results with optional per-result text/highlights/summary (set the nested `contents` object). For agent workflows prefer `contents.highlights=true` — 10× fewer tokens than full text. Pick `type` by latency tier: `instant`~250 ms · `fast`~450 ms · `auto`~1 s (default) · `deep-lite` ~4 s · `deep` 4–15 s · `deep-reasoning` 12–40 s. `includeDomains` and `excludeDomains` are mutually exclusive (max 1200 each). For `category=company` or `category=people`, date filters / `excludeDomains` are NOT supported and will 400.

**Input schema:**
```json
{
  "type": "object",
  "title": "SearchRequest",
  "required": [
    "query"
  ],
  "properties": {
    "type": {
      "enum": [
        "auto",
        "fast",
        "instant",
        "deep-lite",
        "deep",
        "deep-reasoning"
      ],
      "type": "string",
      "title": "SearchType",
      "default": "auto",
      "description": "Types of search available in Exa."
    },
    "query": {
      "type": "string",
      "title": "Query",
      "examples": [
        "Latest research in LLMs",
        "AI companies in Silicon Valley"
      ],
      "description": "The search query string."
    },
    "category": {
      "enum": [
        "company",
        "people",
        "research paper",
        "news",
        "personal site",
        "financial report"
      ],
      "type": "string",
      "title": "SearchCategory",
      "description": "Data categories for focused search in Exa."
    },
    "contents": {
      "type": "object",
      "title": "ContentsOptions",
      "properties": {
        "text": {
          "anyOf": [
            {
              "type": "boolean"
            },
            {
              "type": "object",
              "title": "TextOptions",
              "properties": {
                "verbosity": {
                  "anyOf": [
                    {
                      "enum": [
                        "compact",
                        "standard",
                        "full"
                      ],
                      "type": "string"
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "title": "Verbosity",
                  "default": null,
                  "description": "Level of detail in the extracted text: compact, standard, or full."
                },
                "maxCharacters": {
                  "anyOf": [
                    {
                      "type": "integer"
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "title": "Maxcharacters",
                  "default": null,
                  "description": "Maximum number of characters to extract from the text."
                },
                "excludeSections": {
                  "anyOf": [
                    {
                      "type": "array",
                      "items": {
                        "enum": [
                          "header",
                          "navigation",
                          "banner",
                          "body",
                          "sidebar",
                          "footer",
                          "metadata"
                        ],
                        "type": "string"
                      }
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "title": "Excludesections",
                  "default": null,
                  "description": "List of specific sections to exclude from the text."
                },
                "includeHtmlTags": {
                  "anyOf": [
                    {
                      "type": "boolean"
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "title": "Includehtmltags",
                  "default": null,
                  "description": "Whether to include HTML tags in the extracted text. If omitted, Exa defaults to false."
                },
                "includeSections": {
                  "anyOf": [
                    {
                      "type": "array",
                      "items": {
                        "enum": [
                          "header",
                          "navigation",
                          "banner",
                          "body",
                          "sidebar",
                          "footer",
                          "metadata"
                        ],
                        "type": "string"
                      }
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "title": "Includesections",
                  "default": null,
                  "description": "List of specific sections to include in the text."
                }
              },
              "description": "Options for text content extraction."
            }
          ],
          "title": "Text",
          "description": "Whether to extract text content. Can be a boolean or TextOptions object."
        },
        "extras": {
          "type": "object",
          "title": "ExtrasOptions",
          "properties": {
            "links": {
              "type": "integer",
              "title": "Links",
              "default": 0,
              "description": "Number of links to extract from the page."
            },
            "imageLinks": {
              "type": "integer",
              "title": "Image Links",
              "default": 0,
              "description": "Number of image links to extract from the page."
            }
          },
          "description": "Options for extracting extra information.",
          "additionalProperties": false
        },
        "summary": {
          "anyOf": [
            {
              "type": "boolean"
            },
            {
              "type": "object",
              "title": "SummaryOptions",
              "properties": {
                "query": {
                  "anyOf": [
                    {
                      "type": "string"
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "title": "Query",
                  "default": null,
                  "description": "Specific query to guide the summary generation."
                },
                "schema": {
                  "anyOf": [
                    {
                      "type": "object",
                      "title": "JsonSchema",
                      "properties": {},
                      "description": "Flexible model for JSON schema objects.",
                      "additionalProperties": true
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "default": null,
                  "description": "JSON schema for structured summary output (accepts any JSON-schema-shaped object)."
                }
              },
              "description": "Options for summary generation."
            }
          ],
          "title": "Summary",
          "description": "Whether to generate a summary. Can be a boolean or SummaryOptions object."
        },
        "subpages": {
          "type": "integer",
          "title": "Subpages",
          "default": 0,
          "description": "Number of subpages to crawl per result."
        },
        "highlights": {
          "anyOf": [
            {
              "type": "boolean"
            },
            {
              "type": "object",
              "title": "HighlightsOptions",
              "properties": {
                "query": {
                  "anyOf": [
                    {
                      "type": "string"
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "title": "Query",
                  "default": null,
                  "description": "Specific query to use for extracting highlights."
                },
                "maxCharacters": {
                  "anyOf": [
                    {
                      "type": "integer"
                    },
                    {
                      "type": "null"
                    }
                  ],
                  "title": "Maxcharacters",
                  "default": null,
                  "description": "Maximum number of characters for highlights."
                }
              },
              "description": "Options for highlights extraction."
            }
          ],
          "title": "Highlights",
          "description": "Whether to extract highlights. Can be a boolean or HighlightsOptions object."
        },
        "maxAgeHours": {
          "type": "integer",
          "title": "Max Age Hours",
          "description": "Maximum age of cached content in hours. 0 = always live, -1 = never live."
        },
        "subpageTarget": {
          "anyOf": [
            {
              "type": "string"
            },
            {
              "type": "array",
              "items": {
                "type": "string"
              }
            }
          ],
          "title": "Subpage Target",
          "description": "Keywords to prioritize for subpage selection."
        },
        "livecrawlTimeout": {
          "type": "integer",
          "title": "Livecrawl Timeout",
          "default": 10000,
          "description": "Timeout in milliseconds for live crawling."
        }
      },
      "description": "Options for per-result content retrieval, saving a separate /contents round-trip.",
      "additionalProperties": false
    },
    "compliance": {
      "type": "string",
      "title": "Compliance",
      "examples": [
        "hipaa"
      ],
      "description": "Enterprise-only compliance mode. Currently only 'hipaa'."
    },
    "moderation": {
      "type": "boolean",
      "title": "Moderation",
      "default": false,
      "description": "Enable content moderation to filter unsafe content."
    },
    "numResults": {
      "type": "integer",
      "title": "Num Results",
      "default": 10,
      "maximum": 100,
      "minimum": 1,
      "description": "Desired number of search results. Must be between 1 and 100 (inclusive). Defaults to 10. No pagination is available; larger values increase latency without guaranteeing better coverage."
    },
    "excludeText": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Exclude Text",
      "examples": [
        [
          "outdated information"
        ]
      ],
      "description": "A list containing exactly one phrase (up to 5 words) that must NOT be present in the webpage text. Only one phrase is allowed per request. Example: ['outdated information'] (correct) vs ['outdated', 'wrong'] (incorrect - API will reject multiple phrases)."
    },
    "includeText": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Include Text",
      "examples": [
        [
          "machine learning applications"
        ]
      ],
      "description": "A list containing exactly one phrase (up to 5 words) that must be present in the webpage text. Only one phrase is allowed per request. Example: ['machine learning applications'] (correct) vs ['machine', 'learning'] (incorrect - API will reject multiple phrases)."
    },
    "outputSchema": {
      "type": "object",
      "title": "JsonSchema",
      "properties": {},
      "description": "Flexible model for JSON schema objects.",
      "additionalProperties": true
    },
    "systemPrompt": {
      "type": "string",
      "title": "System Prompt",
      "examples": [
        "Prefer official sources, avoid duplicates."
      ],
      "description": "Instructions guiding synthesized output / search planning for deep variants."
    },
    "userLocation": {
      "type": "string",
      "title": "User Location",
      "examples": [
        "US"
      ],
      "description": "Two-letter ISO country code of the user (e.g., 'US')."
    },
    "excludeDomains": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Exclude Domains",
      "examples": [
        [
          "undesired.com",
          "www.amazon.com",
          "*.ebay.com"
        ]
      ],
      "description": "MUTUALLY EXCLUSIVE WITH includeDomains - provide ONLY ONE of includeDomains or excludeDomains, never both. A list of domain names to specifically exclude from the search results (max 1200). Must be valid domain names containing at least one dot (e.g., 'example.com', 'www.example.com' are valid). Supports subdomain wildcards (e.g., '*.amazon.com') and path filtering (e.g., 'example.com/path'). Must be without protocol (e.g., 'example.com' not 'https://example.com') and without angle brackets."
    },
    "includeDomains": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Include Domains",
      "examples": [
        [
          "example.com",
          "www.another.org",
          "*.substack.com",
          "linkedin.com/company"
        ]
      ],
      "description": "MUTUALLY EXCLUSIVE WITH excludeDomains - provide ONLY ONE of includeDomains or excludeDomains, never both. A list of domain names to specifically include in the search results (max 1200). Must be valid domain names containing at least one dot (e.g., 'example.com', 'www.example.com' are valid). Supports subdomain wildcards (e.g., '*.substack.com') and path filtering (e.g., 'example.com/blog'). Must be without protocol (e.g., 'example.com' not 'https://example.com') and without angle brackets."
    },
    "endPublishedDate": {
      "type": "string",
      "title": "End Published Date",
      "examples": [
        "2023-12-31"
      ],
      "description": "Filters results to include only those published before this ISO 8601 date. NOTE: This filter is NOT supported when category='company' and will be ignored."
    },
    "additionalQueries": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "title": "Additional Queries",
      "examples": [
        [
          "food technology startups Series A"
        ]
      ],
      "description": "Extra query variations for deep-search variants only."
    },
    "startPublishedDate": {
      "type": "string",
      "title": "Start Published Date",
      "examples": [
        "2023-01-01"
      ],
      "description": "Filters results to include only those published after this ISO 8601 date. NOTE: This filter is NOT supported when category='company' and will be ignored."
    }
  },
  "description": "Parameters for an Exa search query, enabling filtering and customization of results."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "CostDollars": {
      "type": "object",
      "title": "CostDollars",
      "properties": {
        "total": {
          "type": "number",
          "title": "Total",
          "description": "Total dollar cost."
        },
        "breakDown": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "CostBreakdown",
            "properties": {
              "cost": {
                "type": "number",
                "title": "Cost",
                "description": "Cost for this operation."
              },
              "count": {
                "type": "integer",
                "title": "Count",
                "description": "Number of operations."
              },
              "operation": {
                "type": "string",
                "title": "Operation",
                "description": "Type of operation."
              }
            },
            "description": "Cost breakdown by operation type."
          },
          "title": "Break Down",
          "description": "Breakdown of costs by operation."
        }
      },
      "description": "Cost information for the request."
    },
    "ExtrasResult": {
      "type": "object",
      "title": "ExtrasResult",
      "properties": {
        "links": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Links",
          "description": "List of extracted links."
        },
        "imageLinks": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Image Links",
          "description": "List of extracted image links."
        }
      },
      "description": "Extra information extracted from a search result."
    },
    "SearchResult": {
      "type": "object",
      "title": "SearchResult",
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "Unique identifier for the search result."
        },
        "url": {
          "type": "string",
          "title": "Url",
          "description": "URL of the search result."
        },
        "text": {
          "type": "string",
          "title": "Text",
          "description": "Extracted text content from the search result webpage (if available)."
        },
        "image": {
          "type": "string",
          "title": "Image",
          "description": "URL of an image associated with the search result (if available)."
        },
        "score": {
          "type": "number",
          "title": "Score",
          "description": "Relevance score of the search result, indicating how well it matches the query."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the search result."
        },
        "author": {
          "type": "string",
          "title": "Author",
          "description": "Author of the search result (if available)."
        },
        "extras": {
          "type": "object",
          "title": "Extras",
          "properties": {
            "links": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Links",
              "description": "List of extracted links."
            },
            "imageLinks": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "title": "Image Links",
              "description": "List of extracted image links."
            }
          },
          "description": "Additional information like links and image links extracted from the result."
        },
        "favicon": {
          "type": "string",
          "title": "Favicon",
          "description": "URL of the favicon for the website of the search result (if available)."
        },
        "summary": {
          "type": "string",
          "title": "Summary",
          "description": "A concise summary of the search result's content (if available)."
        },
        "subpages": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SearchResult",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the search result."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "description": "URL of the search result."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "Extracted text content from the search result webpage (if available)."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "URL of an image associated with the search result (if available)."
              },
              "score": {
                "type": "number",
                "title": "Score",
                "description": "Relevance score of the search result, indicating how well it matches the query."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the search result."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "Author of the search result (if available)."
              },
              "extras": {
                "type": "object",
                "title": "Extras",
                "properties": {
                  "links": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Links",
                    "description": "List of extracted links."
                  },
                  "imageLinks": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Image Links",
                    "description": "List of extracted image links."
                  }
                },
                "description": "Additional information like links and image links extracted from the result."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "URL of the favicon for the website of the search result (if available)."
              },
              "summary": {
                "type": "string",
                "title": "Summary",
                "description": "A concise summary of the search result's content (if available)."
              },
              "subpages": {
                "type": "array",
                "items": {
                  "$ref": "#/$defs/SearchResult"
                },
                "title": "Subpages",
                "description": "List of subpages or related links found within the search result (if available)."
              },
              "highlights": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Highlights",
                "description": "List of highlighted text snippets from the search result that match the query."
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "Publication date of the search result (if available)."
              }
            },
            "description": "Represents an individual item from Exa search results, potentially including extracted text or highlights."
          },
          "title": "Subpages",
          "description": "List of subpages or related links found within the search result (if available)."
        },
        "highlights": {
          "type": "array",
          "items": {
            "type": "string"
          },
          "title": "Highlights",
          "description": "List of highlighted text snippets from the search result that match the query."
        },
        "publishedDate": {
          "type": "string",
          "title": "Published Date",
          "description": "Publication date of the search result (if available)."
        }
      },
      "description": "Represents an individual item from Exa search results, potentially including extracted text or highlights."
    },
    "CostBreakdown": {
      "type": "object",
      "title": "CostBreakdown",
      "properties": {
        "cost": {
          "type": "number",
          "title": "Cost",
          "description": "Cost for this operation."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "Number of operations."
        },
        "operation": {
          "type": "string",
          "title": "Operation",
          "description": "Type of operation."
        }
      },
      "description": "Cost breakdown by operation type."
    },
    "OutputCitation": {
      "type": "object",
      "title": "OutputCitation",
      "properties": {
        "url": {
          "type": "string",
          "title": "Url",
          "description": "URL of the source."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "Title of the source."
        }
      },
      "description": "Citation source for synthesized output grounding."
    },
    "SearchResponse": {
      "type": "object",
      "title": "SearchResponse",
      "required": [
        "requestId",
        "results"
      ],
      "properties": {
        "output": {
          "type": "object",
          "title": "Output",
          "properties": {
            "content": {
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "object",
                  "title": "StructuredOutputContent",
                  "properties": {},
                  "description": "Structured synthesized output matching the user-provided outputSchema.",
                  "additionalProperties": true
                }
              ],
              "title": "Content",
              "description": "The synthesized answer as text, or a structured object matching outputSchema."
            },
            "grounding": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "OutputGrounding",
                "properties": {
                  "field": {
                    "type": "string",
                    "title": "Field",
                    "description": "Output field path grounded by these citations."
                  },
                  "citations": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "OutputCitation",
                      "properties": {
                        "url": {
                          "type": "string",
                          "title": "Url",
                          "description": "URL of the source."
                        },
                        "title": {
                          "type": "string",
                          "title": "Title",
                          "description": "Title of the source."
                        }
                      },
                      "description": "Citation source for synthesized output grounding."
                    },
                    "title": "Citations",
                    "description": "Sources grounding this output field."
                  },
                  "confidence": {
                    "enum": [
                      "low",
                      "medium",
                      "high"
                    ],
                    "type": "string",
                    "title": "Confidence",
                    "description": "Confidence score for this grounded output field."
                  }
                },
                "description": "Grounding information for synthesized output."
              },
              "title": "Grounding",
              "description": "Field-level citations and confidence scores."
            }
          },
          "description": "Synthesized output with content and grounding when outputSchema is provided."
        },
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SearchResult",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the search result."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "description": "URL of the search result."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "Extracted text content from the search result webpage (if available)."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "URL of an image associated with the search result (if available)."
              },
              "score": {
                "type": "number",
                "title": "Score",
                "description": "Relevance score of the search result, indicating how well it matches the query."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the search result."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "Author of the search result (if available)."
              },
              "extras": {
                "type": "object",
                "title": "Extras",
                "properties": {
                  "links": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Links",
                    "description": "List of extracted links."
                  },
                  "imageLinks": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Image Links",
                    "description": "List of extracted image links."
                  }
                },
                "description": "Additional information like links and image links extracted from the result."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "URL of the favicon for the website of the search result (if available)."
              },
              "summary": {
                "type": "string",
                "title": "Summary",
                "description": "A concise summary of the search result's content (if available)."
              },
              "subpages": {
                "type": "array",
                "items": {
                  "$ref": "#/$defs/SearchResult"
                },
                "title": "Subpages",
                "description": "List of subpages or related links found within the search result (if available)."
              },
              "highlights": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Highlights",
                "description": "List of highlighted text snippets from the search result that match the query."
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "Publication date of the search result (if available)."
              }
            },
            "description": "Represents an individual item from Exa search results, potentially including extracted text or highlights."
          },
          "title": "Results",
          "description": "A list of `SearchResult` objects, each representing an individual item found by the search."
        },
        "requestId": {
          "type": "string",
          "title": "Request Id",
          "description": "A unique identifier for this specific search request."
        },
        "searchType": {
          "type": "string",
          "title": "Search Type",
          "description": "For auto searches, indicates which search type was selected."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "properties": {
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total dollar cost."
            },
            "breakDown": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "CostBreakdown",
                "properties": {
                  "cost": {
                    "type": "number",
                    "title": "Cost",
                    "description": "Cost for this operation."
                  },
                  "count": {
                    "type": "integer",
                    "title": "Count",
                    "description": "Number of operations."
                  },
                  "operation": {
                    "type": "string",
                    "title": "Operation",
                    "description": "Type of operation."
                  }
                },
                "description": "Cost breakdown by operation type."
              },
              "title": "Break Down",
              "description": "Breakdown of costs by operation."
            }
          },
          "description": "Cost information for the request."
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Message from Composio explaining any modifications made to the request parameters during execution."
        }
      },
      "description": "Contains Exa search results, including found documents and search metadata."
    },
    "OutputGrounding": {
      "type": "object",
      "title": "OutputGrounding",
      "properties": {
        "field": {
          "type": "string",
          "title": "Field",
          "description": "Output field path grounded by these citations."
        },
        "citations": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "OutputCitation",
            "properties": {
              "url": {
                "type": "string",
                "title": "Url",
                "description": "URL of the source."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the source."
              }
            },
            "description": "Citation source for synthesized output grounding."
          },
          "title": "Citations",
          "description": "Sources grounding this output field."
        },
        "confidence": {
          "enum": [
            "low",
            "medium",
            "high"
          ],
          "type": "string",
          "title": "Confidence",
          "description": "Confidence score for this grounded output field."
        }
      },
      "description": "Grounding information for synthesized output."
    },
    "SynthesizedOutput": {
      "type": "object",
      "title": "SynthesizedOutput",
      "properties": {
        "content": {
          "anyOf": [
            {
              "type": "string"
            },
            {
              "type": "object",
              "title": "StructuredOutputContent",
              "properties": {},
              "description": "Structured synthesized output matching the user-provided outputSchema.",
              "additionalProperties": true
            }
          ],
          "title": "Content",
          "description": "The synthesized answer as text, or a structured object matching outputSchema."
        },
        "grounding": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "OutputGrounding",
            "properties": {
              "field": {
                "type": "string",
                "title": "Field",
                "description": "Output field path grounded by these citations."
              },
              "citations": {
                "type": "array",
                "items": {
                  "type": "object",
                  "title": "OutputCitation",
                  "properties": {
                    "url": {
                      "type": "string",
                      "title": "Url",
                      "description": "URL of the source."
                    },
                    "title": {
                      "type": "string",
                      "title": "Title",
                      "description": "Title of the source."
                    }
                  },
                  "description": "Citation source for synthesized output grounding."
                },
                "title": "Citations",
                "description": "Sources grounding this output field."
              },
              "confidence": {
                "enum": [
                  "low",
                  "medium",
                  "high"
                ],
                "type": "string",
                "title": "Confidence",
                "description": "Confidence score for this grounded output field."
              }
            },
            "description": "Grounding information for synthesized output."
          },
          "title": "Grounding",
          "description": "Field-level citations and confidence scores."
        }
      },
      "description": "Synthesized output when outputSchema is provided."
    },
    "StructuredOutputContent": {
      "type": "object",
      "title": "StructuredOutputContent",
      "properties": {},
      "description": "Structured synthesized output matching the user-provided outputSchema.",
      "additionalProperties": true
    }
  },
  "title": "SearchResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "requestId",
        "results"
      ],
      "properties": {
        "output": {
          "type": "object",
          "title": "Output",
          "properties": {
            "content": {
              "anyOf": [
                {
                  "type": "string"
                },
                {
                  "type": "object",
                  "title": "StructuredOutputContent",
                  "properties": {},
                  "description": "Structured synthesized output matching the user-provided outputSchema.",
                  "additionalProperties": true
                }
              ],
              "title": "Content",
              "description": "The synthesized answer as text, or a structured object matching outputSchema."
            },
            "grounding": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "OutputGrounding",
                "properties": {
                  "field": {
                    "type": "string",
                    "title": "Field",
                    "description": "Output field path grounded by these citations."
                  },
                  "citations": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "title": "OutputCitation",
                      "properties": {
                        "url": {
                          "type": "string",
                          "title": "Url",
                          "description": "URL of the source."
                        },
                        "title": {
                          "type": "string",
                          "title": "Title",
                          "description": "Title of the source."
                        }
                      },
                      "description": "Citation source for synthesized output grounding."
                    },
                    "title": "Citations",
                    "description": "Sources grounding this output field."
                  },
                  "confidence": {
                    "enum": [
                      "low",
                      "medium",
                      "high"
                    ],
                    "type": "string",
                    "title": "Confidence",
                    "description": "Confidence score for this grounded output field."
                  }
                },
                "description": "Grounding information for synthesized output."
              },
              "title": "Grounding",
              "description": "Field-level citations and confidence scores."
            }
          },
          "description": "Synthesized output with content and grounding when outputSchema is provided."
        },
        "results": {
          "type": "array",
          "items": {
            "type": "object",
            "title": "SearchResult",
            "properties": {
              "id": {
                "type": "string",
                "title": "Id",
                "description": "Unique identifier for the search result."
              },
              "url": {
                "type": "string",
                "title": "Url",
                "description": "URL of the search result."
              },
              "text": {
                "type": "string",
                "title": "Text",
                "description": "Extracted text content from the search result webpage (if available)."
              },
              "image": {
                "type": "string",
                "title": "Image",
                "description": "URL of an image associated with the search result (if available)."
              },
              "score": {
                "type": "number",
                "title": "Score",
                "description": "Relevance score of the search result, indicating how well it matches the query."
              },
              "title": {
                "type": "string",
                "title": "Title",
                "description": "Title of the search result."
              },
              "author": {
                "type": "string",
                "title": "Author",
                "description": "Author of the search result (if available)."
              },
              "extras": {
                "type": "object",
                "title": "Extras",
                "properties": {
                  "links": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Links",
                    "description": "List of extracted links."
                  },
                  "imageLinks": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    },
                    "title": "Image Links",
                    "description": "List of extracted image links."
                  }
                },
                "description": "Additional information like links and image links extracted from the result."
              },
              "favicon": {
                "type": "string",
                "title": "Favicon",
                "description": "URL of the favicon for the website of the search result (if available)."
              },
              "summary": {
                "type": "string",
                "title": "Summary",
                "description": "A concise summary of the search result's content (if available)."
              },
              "subpages": {
                "type": "array",
                "items": {
                  "$ref": "#/$defs/SearchResult"
                },
                "title": "Subpages",
                "description": "List of subpages or related links found within the search result (if available)."
              },
              "highlights": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "title": "Highlights",
                "description": "List of highlighted text snippets from the search result that match the query."
              },
              "publishedDate": {
                "type": "string",
                "title": "Published Date",
                "description": "Publication date of the search result (if available)."
              }
            },
            "description": "Represents an individual item from Exa search results, potentially including extracted text or highlights."
          },
          "title": "Results",
          "description": "A list of `SearchResult` objects, each representing an individual item found by the search."
        },
        "requestId": {
          "type": "string",
          "title": "Request Id",
          "description": "A unique identifier for this specific search request."
        },
        "searchType": {
          "type": "string",
          "title": "Search Type",
          "description": "For auto searches, indicates which search type was selected."
        },
        "costDollars": {
          "type": "object",
          "title": "Cost Dollars",
          "properties": {
            "total": {
              "type": "number",
              "title": "Total",
              "description": "Total dollar cost."
            },
            "breakDown": {
              "type": "array",
              "items": {
                "type": "object",
                "title": "CostBreakdown",
                "properties": {
                  "cost": {
                    "type": "number",
                    "title": "Cost",
                    "description": "Cost for this operation."
                  },
                  "count": {
                    "type": "integer",
                    "title": "Count",
                    "description": "Number of operations."
                  },
                  "operation": {
                    "type": "string",
                    "title": "Operation",
                    "description": "Type of operation."
                  }
                },
                "description": "Cost breakdown by operation type."
              },
              "title": "Break Down",
              "description": "Breakdown of costs by operation."
            }
          },
          "description": "Cost information for the request."
        },
        "composio_execution_message": {
          "type": "string",
          "title": "Composio Execution Message",
          "description": "Message from Composio explaining any modifications made to the request parameters during execution."
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

## EXA_UPDATE_IMPORT
Tool to update an import configuration by ID. Use when you need to modify an import's title or metadata.

**Input schema:**
```json
{
  "type": "object",
  "title": "UpdateImportRequest",
  "required": [
    "id"
  ],
  "properties": {
    "id": {
      "type": "string",
      "title": "Id",
      "examples": [
        "import_id_123"
      ],
      "description": "The ID of the import to update."
    },
    "title": {
      "type": "string",
      "title": "Title",
      "examples": [
        "Monthly Customer Import"
      ],
      "description": "New title for the import. Leave null if unchanged."
    },
    "metadata": {
      "type": "object",
      "title": "Metadata",
      "examples": [
        {
          "key": "value"
        }
      ],
      "description": "Key-value pairs to attach to the import. Leave null if unchanged.",
      "additionalProperties": true
    }
  },
  "description": "Request model for updating an import configuration."
}
```

**Output schema:**
```json
{
  "type": "object",
  "$defs": {
    "Entity": {
      "type": "object",
      "title": "Entity",
      "required": [
        "type"
      ],
      "properties": {
        "type": {
          "type": "string",
          "title": "Type",
          "description": "The type of entity the import contains (e.g., 'company')."
        }
      },
      "description": "Represents the entity type contained in the import object."
    },
    "UpdateImportResponse": {
      "type": "object",
      "title": "UpdateImportResponse",
      "required": [
        "id",
        "object",
        "status",
        "format",
        "entity",
        "count",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "The number of entities in the import."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of entity the import contains (e.g., 'company')."
            }
          },
          "description": "The entity information for the import."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "The format of the import (csv or webset)."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The type of object, always 'import'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the import (pending, processing, completed, or failed)."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the import failed, if applicable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Key-value pairs associated with this import object.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the import was last updated."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason the import failed, if applicable (invalid_format, missing_identifier, etc)."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "A message describing why the import failed, if any."
        }
      },
      "description": "Response model returned after updating an import."
    }
  },
  "title": "UpdateImportResponseWrapper",
  "required": [
    "data",
    "successful"
  ],
  "properties": {
    "data": {
      "type": "object",
      "title": "Data",
      "required": [
        "id",
        "object",
        "status",
        "format",
        "entity",
        "count",
        "metadata",
        "createdAt",
        "updatedAt"
      ],
      "properties": {
        "id": {
          "type": "string",
          "title": "Id",
          "description": "The unique identifier for the import."
        },
        "count": {
          "type": "integer",
          "title": "Count",
          "description": "The number of entities in the import."
        },
        "title": {
          "type": "string",
          "title": "Title",
          "description": "The title of the import."
        },
        "entity": {
          "type": "object",
          "title": "Entity",
          "required": [
            "type"
          ],
          "properties": {
            "type": {
              "type": "string",
              "title": "Type",
              "description": "The type of entity the import contains (e.g., 'company')."
            }
          },
          "description": "The entity information for the import."
        },
        "format": {
          "type": "string",
          "title": "Format",
          "description": "The format of the import (csv or webset)."
        },
        "object": {
          "type": "string",
          "title": "Object",
          "description": "The type of object, always 'import'."
        },
        "status": {
          "type": "string",
          "title": "Status",
          "description": "The status of the import (pending, processing, completed, or failed)."
        },
        "failedAt": {
          "type": "string",
          "title": "Failed At",
          "description": "Timestamp when the import failed, if applicable."
        },
        "metadata": {
          "type": "object",
          "title": "Metadata",
          "description": "Key-value pairs associated with this import object.",
          "additionalProperties": true
        },
        "createdAt": {
          "type": "string",
          "title": "Created At",
          "description": "Timestamp when the import was created."
        },
        "updatedAt": {
          "type": "string",
          "title": "Updated At",
          "description": "Timestamp when the import was last updated."
        },
        "failedReason": {
          "type": "string",
          "title": "Failed Reason",
          "description": "Reason the import failed, if applicable (invalid_format, missing_identifier, etc)."
        },
        "failedMessage": {
          "type": "string",
          "title": "Failed Message",
          "description": "A message describing why the import failed, if any."
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
