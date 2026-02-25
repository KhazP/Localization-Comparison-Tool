import 'package:equatable/equatable.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';

abstract class AiServicesEvent extends Equatable {
  const AiServicesEvent();

  @override
  List<Object?> get props => [];
}

class LoadAiServicesSettings extends AiServicesEvent {}

class UpdateAiTranslationService extends AiServicesEvent {
  final String service;
  const UpdateAiTranslationService(this.service);
  @override
  List<Object> get props => [service];
}

class UpdateGoogleTranslateApiKey extends AiServicesEvent {
  final String apiKey;
  const UpdateGoogleTranslateApiKey(this.apiKey);
  @override
  List<Object> get props => [apiKey];
}

class UpdateDeeplApiKey extends AiServicesEvent {
  final String apiKey;
  const UpdateDeeplApiKey(this.apiKey);
  @override
  List<Object> get props => [apiKey];
}

class UpdateEnableAiTranslation extends AiServicesEvent {
  final bool enabled;
  const UpdateEnableAiTranslation(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateTranslationConfidenceThreshold extends AiServicesEvent {
  final double threshold;
  const UpdateTranslationConfidenceThreshold(this.threshold);
  @override
  List<Object> get props => [threshold];
}

class UpdateGeminiApiKey extends AiServicesEvent {
  final String apiKey;
  const UpdateGeminiApiKey(this.apiKey);
  @override
  List<Object> get props => [apiKey];
}

class UpdateOpenAiApiKey extends AiServicesEvent {
  final String apiKey;
  const UpdateOpenAiApiKey(this.apiKey);
  @override
  List<Object> get props => [apiKey];
}

class TestApiKey extends AiServicesEvent {
  final ApiProvider provider;
  final String apiKey;
  const TestApiKey({required this.provider, required this.apiKey});
  @override
  List<Object> get props => [provider, apiKey];
}

class FetchAvailableModels extends AiServicesEvent {
  final ApiProvider provider;
  const FetchAvailableModels(this.provider);
  @override
  List<Object> get props => [provider];
}

class UpdateAiTemperature extends AiServicesEvent {
  final double temperature;
  const UpdateAiTemperature(this.temperature);
  @override
  List<Object> get props => [temperature];
}

class UpdateMaxTokens extends AiServicesEvent {
  final int maxTokens;
  const UpdateMaxTokens(this.maxTokens);
  @override
  List<Object> get props => [maxTokens];
}

class UpdateDefaultAiModel extends AiServicesEvent {
  final String model;
  const UpdateDefaultAiModel(this.model);
  @override
  List<Object> get props => [model];
}

class UpdateSystemTranslationContext extends AiServicesEvent {
  final String context;
  const UpdateSystemTranslationContext(this.context);
  @override
  List<Object> get props => [context];
}

class UpdateContextStringsCount extends AiServicesEvent {
  final int count;
  const UpdateContextStringsCount(this.count);
  @override
  List<Object> get props => [count];
}

class UpdateIncludeContextStrings extends AiServicesEvent {
  final bool include;
  const UpdateIncludeContextStrings(this.include);
  @override
  List<Object> get props => [include];
}

class UpdateEnableTranslationMemory extends AiServicesEvent {
  final bool enabled;
  const UpdateEnableTranslationMemory(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateEnableFuzzyFill extends AiServicesEvent {
  final bool enabled;
  const UpdateEnableFuzzyFill(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateFuzzyFillMinScore extends AiServicesEvent {
  final double minScore;
  const UpdateFuzzyFillMinScore(this.minScore);
  @override
  List<Object> get props => [minScore];
}

class UpdateFuzzyFillAutoApply extends AiServicesEvent {
  final bool enabled;
  const UpdateFuzzyFillAutoApply(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateFuzzyFillOnlyEmptyTargets extends AiServicesEvent {
  final bool enabled;
  const UpdateFuzzyFillOnlyEmptyTargets(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateFuzzyFillMatchLimit extends AiServicesEvent {
  final int limit;
  const UpdateFuzzyFillMatchLimit(this.limit);
  @override
  List<Object> get props => [limit];
}

class UpdateFuzzyFillExactMatchesOnly extends AiServicesEvent {
  final bool enabled;
  const UpdateFuzzyFillExactMatchesOnly(this.enabled);
  @override
  List<Object> get props => [enabled];
}

class UpdateTranslationStrategy extends AiServicesEvent {
  final String strategy;
  const UpdateTranslationStrategy(this.strategy);
  @override
  List<Object> get props => [strategy];
}

class ResetAiServicesSettings extends AiServicesEvent {}
